Message-Id: <200504291302.j3TD2B8R003613@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Davide Bolcioni'" <dbolcioni@3di.it>
Cc: <fedora-selinux-list@redhat.com>, "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Is there a SELinux tutorial for ISVs ?
Date: Fri, 29 Apr 2005 09:02:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <42710736.2020001@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] 
> On Behalf Of Daniel J Walsh
> Sent: Thursday, April 28, 2005 11:55 AM
> To: Davide Bolcioni
> Cc: fedora-selinux-list@redhat.com; SELinux
> Subject: Re: Is there a SELinux tutorial for ISVs ?
> 
> This string of messages brings up something I wanted to get a 
> conversation going on how to handle non OS Provided policy.
> 
> We all know we need a better mechanism for handling "binary" policy in 
> the future.  ( I think the future is now.) I see three people 
> providing policy.
> 
> 1. OS Provider with base policy.  (It would also be nice if the base 
> policy got broken into several policies and only the policy of the 
> running service would be loaded.  If we got to this state we would 
> need a new mechanism for restoring file context since file_context 
> might not meet the currently loaded policy.
> 

In the binary policy work, the base is simply a binary module that is fully
self-contained to guarantee that there will be an internally consistent /
coherent policy at all times. That policy can be arbitrarily small, however.

As for only enabling policy for certain services I see three options:

1) Policy for all services is always loaded (current practice).
2) Policy for services that are installed is always loaded.
3) Policy for services that are installed is loaded on service start.

1 is obviously problematic because of wasted resources and privileged
application domains being present when they should not be (not to mention 3rd
party policy). We considered 3 when we started the binary module work, but
decided that it was too complicated with little benefit. Additionally, I think
that it is _very_ desirable to limit relabeling as much as possible. It is error
prone and risky in terms of security.

2 is what we are targeting. The installation of a new service in the model I am
proposing would

1) Install the binary policy module to a place on the filesystem managed by RPM
(for example /etc/selinux/policy-name/installed-modules).

2) Load the policy by installing it with semodule (semodule -i policy.pp - .pp
is for policy package which is the binary policy and file contexts). This will
install the module into a managed location (for example
/etc/selinux/policy-name/active-modules) and load it into the kernel.

3) RPM would then label files as it installs the application.

The binary module infrastructure also always creates a complete file_context
like the current system, so that can be used for whatever labeling needs to be
done.

> 2. Third Party application developers.  As the use of targeted policy 
> has begun to take off, Third Party ISV have started to question how 
> they can play in this world.
> 
> I see Tresys Stuff solving the problems of both of the above.
> 

That is the plan - we are porting the recent changes to
libsepol/libselinux/checkpolicy to our tree and will start upstreaming the
binary policy work soon. I am targeting getting this integrated by June.

> 3 Local User customization and minor policies.  Currently we have 
> people using audit2allow creating files in domains/misc and then
> reloading policy.   We need a mechanism for users to be able to do this
> without recompiling policy.    Also more significantly how
> do we handle the small diffed apache_domain stuff.  A couple of months 
> ago I redesigned apache policy to have a macro called apache_domain.  
> A user could create a new apache_XYZ.te file with
> 
> apache_domain(XYZ)
> Followed by a few allow rules and be able to get their cgi scripts 
> working without turning off apache protection or running their script 
> in httpd_unconfined_script_t.
> 
> The problem is the only way to do this is to install policy sources and
> muck around.    I think we to have some shared library mechanism
> where a few well known macros could be defined and users could easily 
> build their own custom policy.
> 

We are actively working on what we are calling reference policy. This attempts
to create just such a 'shared library' mechanism among other goals. On the
source level it creates abstractions in the form of layers and modules. Each
module, which contains the policy for a well-defined functional area, exports a
set of interfaces - macros that allow access to its resources.

There is a presentation that we did on this work available at
http://tresys.com/Downloads/selinux_dev/reference-policy.pdf, which may give you
an idea of what we are trying to accomplish. Also, we are starting a sourceforge
project for this that will be up soon. We are making rapid progress on this and
can release the policies that we have done so far when the project set up. If
anyone would like to see what we have let me know and I will get you a tarball
off list.

I think that the next step is to add the interface idea to the underlying binary
module language so that external policies can start being dependent not on types
but interfaces. If these stabilize enough it should be possible to write to this
abstraction layer and have a single binary module work across many base
policies.

> 
> Anyways I think we need more discussion on handling third party and 
> user customization of policy outside of the current make tree stuff.
> 

I agree. We are trying to tackle these problems, but need input about exactly
what people need.

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> Dan
> 
> Dan
> 
> --
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes as
the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
