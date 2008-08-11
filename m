Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7B2IC6S010686
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2008 22:18:12 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7B2IBb2022162
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 02:18:11 GMT
Date: Mon, 11 Aug 2008 12:17:48 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: libvir-list@redhat.com
cc: selinux@tycho.nsa.gov
Subject: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based
 virtualization
Message-ID: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is to announce the formation of the sVirt project, which aims to 
integrate SELinux and Linux-based virtualization (KVM et al).

The idea has been discussed a few times over the last year or so, and in 
recent weeks, a few Fedora folk (such as Dan Walsh, Daniel Berrange and 
myself) have put together some requirements and had some preliminary 
technical discussions.

The requirements document and initital technical considerations are 
included below inline for review and discussion.

In a nutshell, we'd like to be able to apply distinct security labels to 
individual VM instances and their resources, so that they can be isolated 
from each other via MAC policy.  We want this to "just work" when 
configuring and managing VMs via the libvirt toolchain, e.g. provide a 
simple option during VM creation to make the VM "isolated", and have the 
toolchain do all the labeling and policy configuration behind the scenes. 
Greater detail may be found in the requirements document.

If you wish to contribute, please reply to this email with any 
enhancements to the requirements, technical ideas, issues etc.  I'd 
suggest joining the libvir-list (in the to: line) if not already on it, as 
that is where the integration work is expected to happen.

There's also a wiki page:
http://selinuxproject.org/page/SVirt


------------------------------------------------------------------------

                                                            11 Aug 2008

    sVirt: Integration of SELinux and Linux-based Virtualization
       
           Requirements and Design Considerations v1.0


1.  Introduction

    This document establishes a set of functional and technical
    requirements for integrating SELinux with Linux-based
    virtualization (i.e. Linux-as-hypervisor schemes such as KVM/Qemu
    amd lguest).
    
    Note that non-Linux hypervisor models such as Xen are not covered
    explicitly in this document, although may be afforded some MAC
    coverage due to shared infrastructure (e.g. libvirt).  Non-Linux
    hypervisor models may considered further at a later stage.
    
    Also, while this document focuses on SELinux as the MAC scheme,
    consideration should be given to ensuring support for other
    label-based MAC schemes.


1.1  Rationale

    With increased use of virtualization, one security benefit of
    physically separated systems -- strong isolation -- is reduced, an
    issue which may be ameliorated with the application of Mandatory
    Access Control (MAC) security in the host system.
    
    Integration of MAC with virtualization will also help increase the
    overall robustness and security assurance of both host and guest
    systems.  Many threats arising from flaws in the VM environment, or
    misconfiguration, may be mitigated through tighter isolation and
    specific MAC policy enforcement.
    
    By incorporating MAC support into the virtualization toolchain and
    documentation, users will also be able to make more use of the MAC
    security capabilities provided by the OS.


1.2  Use-cases

    The following use-cases have been identified:
    
      o Providing virtualized services with a level of isolation
        similar to that previously afforded by physical separation.
        
      o Increased protection of the host from untrusted VM guests (e.g.
        for VM hosting providers, grid/cloud servers etc.).
        
      o Increased protection of VM guests from each other in the event
        of host flaws or misconfiguration.  Some protection may also be
        provided against a compromised host.
        
      o Consolidating access to multiple networks which require strong
        isolation from each other (e.g. military, government, corporate
        extranets, internal "Chinese wall" separation etc.)
        
      o Strongly isolating desktop applications by running them in
        separately labeled VMs (e.g. online banking in one VM and World
        of Warcraft in another; opening untrusted office documents in
        an isolated VM for view/print only).
        
      o Forensic analysis of disk images, binaries, browser scripts
        etc. in a highly isolated VM, protecting both the host system
        and the integrity of the components under analysis.
        
      o Isolated test environments, preventing e.g. simulated trades
        from entering a production system, leakage of sensitive
        customer data to internal networks etc.
        
      o General ability to specify a wide range of high-level security
        goals for virtualization through flexible MAC policy.
 

2. Current Situation

    SELinux is already able to provide general MAC protection to
    Linux-based virtualization, such as protecting the integrity and
    confidentiality of disk images and providing strong isolation of
    Linux hypervisor processes from the rest of the system.
    
    There is, however, no explicit support for Linux-based
    virtualization in SELinux, and all VMs currently run in the same
    security context.  Thus, there is no MAC isolation applied between
    VMs.
    
3. Functional Security Requirements

    3.1  Strong isolation between active VMs
    
    Running different VMs with different MAC labels allows stronger
    isolation between VMs, reducing risks arising from flaws in or
    misconfiguration of the VM environment.  For example, the threat of
    a rogue VM exploiting a flaw in KVM could be greatly reduced if it
    is isolated from other VMs by MAC security policy.


    3.2  Improved control over access to VM resources
    
    Distinct MAC labeling of resources belonging to VMs (disk images,
    disk partitions etc.) binds VM instances to those resources,
    ensuring that VMs can only access their own resources.  This can
    protect the VM from invalid VM resources; and protect VM resources
    from flawed or misconfigured VMs.
      

    3.3  Improved control over access to shared resources
    
    Where VMs may share resources (e.g. miscellaneous devices, virtual
    networking, read-only disk images etc.), fine-grained MAC policy
    may be specified to control information flow between VMs.
    

    3.4  Fine-grained interaction with the host

    With distinct labeling of VMs and their resources, interactions
    with host entities on a per-VM basis may then be controlled by MAC
    policy.
    
    An example of this would be to safely allow different users on the
    host to administer different VMs.  Configuration of this could be
    managed via the RBAC scheme integrated with SELinux.
    

    3.5  Coarse MAC containment of VMs
  
    High-level security constraints may be applied to different VMs, to
    allow simplified lock-down of the overall system.  For example, a
    VM may be restricted so that it cannot transmit TCP traffic on port
    25 via virtual networking (i.e. the guest cannot be used as a spam
    bot even if it is compromised via a rootkit).
    

    3.6  Leverage general MAC architecture
  
    As MAC is extended to the desktop, it will be possible to apply
    uniform MAC policy to the OS, desktop and Linux-based
    virtualization components.  This will provide a basis for a variety
    of sophisticated security applications such as a virtualized MLS
    desktop with different windows running VMs at different security
    levels.
  

4.  Design Considerations

    4.1  Consensus in preliminary discussion appears to be that adding
         MAC to libvirt will be the most effective approach.  Support
         may then be extended to virsh, virt-manager, oVirt etc.
       
    4.2  Initially, sVirt should "just work" as a means to isolate VMs,
         with minimal administrative interaction.  e.g. an option is
         added to virt-manager which allows a VM to be designated as
         "isolated", and from then on, it is automatically run in a
         separate security context, with policy etc. being generated
         and managed by libvirt.
       
    4.3  We need to consider very carefully exactly how VMs will be
         launched and controlled e.g. overall security ultimately must
         be enforced by the host kernel, even though VM launch will be
         initially controlled by host userspace.

    4.4  We need to consider overall management of labeling both
         locally and in distributed environments (e.g. oVirt), as well
         as situations where VMs may be migrated between systems,
         backed up etc.
         
         One possible approach may be to represent the security label
         as the UUID of the guest and then translate that to locally
         meaningful values as needed.
       
    4.5  MAC controls/policy will need to be considered for any control
         planes (e.g. /dev/kvm).
  
    4.6  We need to ensure that we have high-level management tools
         available from the start, avoiding past mistakes with SELinux
         where we dropped a bunch of complicated pieces in the user's
         lap.  All aspects of sVirt must be managed by the via the virt
         tools and only present high-level abstractions to the user
         (and then, only if essential).

    4.7  As sVirt involves creating and managing arbitrary numbers of
         security labels, we will need to address the effects of label
         space explosion and resulting complexity.
       
         Possible approaches already discussed include:
         
           - SELinux RBAC or IBAC mechanisms.
           
           - MCS labels.  This has the possible advantage of not
             requiring any policy changes for simple isolation: just
             have a general policy which applies to all MCS labels, and
             possibly customize behavior via the type.
           
             e.g.
          
             system_u:object_r:virt_image_t:c1
                               ^            ^
                               type         mcs label
                            

          
             'c0' = isolated inactive VM image/device.
             
             'cN' = dynamically assigned MCS label for active VM, bound
                    to the UUID, and translated via MCS translation
                    file.  i.e. a user running ls -Z or ps -Z will see
                    the UUID instead of cN.
          
           
             'virt_image_t' = standard VM which is also isolated if an
                              MCS label is present.
                            
             'virt_image_nonet_t' = VM with no network access at all.
           
              etc.
            
              So, MCS is used to enforce VM isolation, Type is used to
              enforce general security behavior.  We can then provide a
              high-level GUI interface for selecting this behavior
              without the admin knowing anything about SELinux.
              
              Note: proof of concept testing has been performed using
              MCS labels, which appears to be workable at this stage.

           - Utilize the new hierarchical types being proposed upstream by
             NEC.  (No analysis done yet).


    4.8  Accessing images via shared storage will present challenges as
         we do not yet have labeling for networked filesystems.
         
    4.9  We must ensure that any MAC support integrated into libvirt is
         readily debuggable.  e.g. hook into auditsp to actively
         process policy violations and handle them via the virt
         toolchain; also develop good setroubleshoot plugins.

    4.10 {lib}semanage needs performance optimization work to reduce
         impact on the virt toolchain.

------------------------------------------------------------------------


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
