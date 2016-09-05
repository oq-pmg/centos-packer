# Concept
Prerequisites:

1. Windows 7
2. VirtualBox 

Target: setup Minimal CentOS 7.2 environment, stripped down to following working conditions:

1. Able to install
2. Able to boot properly
3. Working network (dhclient)
4. Working yum
5. Running sshd service
6. Minimize attack/vulnerability surface to reduce maintenance

To Do:

1. Kickstart file
2. Packer template

# Decisions

## Optional packages removal: Kickstart vs. CM tool (Puppet, CFengine etc)

Initial OS state shouldn't be maintained - that is, stripped down image used to deploy some useful workloads, therefore state will change.

Kickstart approach - exclude set of packages from default bundle once, don't care about maintaining state. 

CM approach - guarantee certain state of environment (here - presense/absence of packages). Adding workloads will require to review and update CM guarantees (including dependency handling).

|Approach|Pro's|Con's|
|---|---|---|
|Kickstart| Less maintenance overhead; Can provide guarantee of packages to install (w/o --ignoremissing) | Can't guarantee packages to be removed (?) |
|CM tool| Designed to maintain state; Can execute standalone policy/manifest file | Support overhead; Separating initial requirements from further state changes will make things more complex => less stable |

**Decision:** Use CM tool in stand-alone (serverless) mode

## CM Tool: Puppet vs. CFengine
|Solution|Pro's|Con's|
|---|---|---|
|Puppet| Huge community; Windows+Linux support (MOF) | Developed since 2005 |
|CFengine| Developed since 1993; A lot of sientific research behind the product | Small community; Poor Windows support in Community Edition |

**Decision:** Puppet

## Puppet packaging: Upstream (CentOS) vs. Vendor (PuppetLabs)

|Approach|Pro's|Con's|
|---|---|---|
|CentOS| Consistent security patches | Version lag |
|PuppetLabs| Most recent version available | No guarantee for dependent packages to be updated |

**Decision:**
