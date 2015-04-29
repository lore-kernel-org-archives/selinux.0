Message-ID: <554115E4.1030700@tycho.nsa.gov>
Date: Wed, 29 Apr 2015 13:33:24 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andrew Holway <andrew.holway@otternetworks.de>, selinux@tycho.nsa.gov
Subject: Re: SELinux policy for Xen with CloudStack
References: <CAEcA1_ur1JCYfQfH4T9CPjVSRC+emjr5Prp7vO-geVj+U+bsJg@mail.gmail.com>
In-Reply-To: <CAEcA1_ur1JCYfQfH4T9CPjVSRC+emjr5Prp7vO-geVj+U+bsJg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2015 12:52 PM, Andrew Holway wrote:
> Hi,
> 
> I have a customer that is asking me to make investigations about setting
> up CloudStack with SELinux. I asked Daniel Walsh and it seems that KVM
> is covered with sVirt in Libvirt however XenServer is a big question
> mark. Should I assume that no work has been done to cover Xen with SELinux?

In the case of Xen, the correct question is whether it is using the XSM
framework and Flask security module (effectively SELinux for the Xen
hypervisor, if you like), and whether they are using SELinux to harden
dom0 and confine any qemu instances.  I don't know offhand whether they
are doing so in CloudStack / XenServer.
