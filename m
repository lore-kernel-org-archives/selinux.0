From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Karl MacMillan" <kmacmillan@tresys.com>
Subject: Re: Now that SELinux supports booleans should we replace tunables with booleans?
Date: Thu, 15 Apr 2004 02:19:27 +1000
Cc: "'Tom Mitchell'" <mitch48@sbcglobal.net>,
   "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>
References: <200404141315.i3EDFkJx015414@gotham.columbia.tresys.com>
In-Reply-To: <200404141315.i3EDFkJx015414@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404150219.27857.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Apr 2004 23:16, "Karl MacMillan" <kmacmillan@tresys.com> wrote:
> I'm not certain this is the case. Booleans allow for fine-grained control
> over policy changes by domains without full policy privileges (see my other
> recent mail in this thread for more on this). This makes it easier to
> analyze a policy ahead of time to make certain that it meats your security
> goals in all configurations.

I agree that using tunable.te instead of booleans does not make it any easier 
for us (as distribution vendors) to analyse the complete policy.  However I 
believe that it does make it significantly easier for users to analyse the 
configurations that they will use.  On my machines I run significantly 
tighter security settings than we ship for Fedora Core (more like what we 
will probably ship for RHEL 4).  So to analyse the policy for my own personal 
use I would not want to consider options such as ssh_sysadm_login, 
xdm_sysadm_login, nfs_home_dirs, and allow_user_direct_mouse as they will 
never be enabled on any machines which matter to me.

We currently have 21 tunable.te options, most of them are options to turn 
things off, so you can analyse the policy with them turned on and if the 
results of that analysis are acceptable then you can be sure that turning 
those options off will only make things more secure.

However some options are either/or options.  Such as whether to run sshd from 
inetd or as a daemon.  In these cases both options have different security 
implications.  I guess you could analyse the union of the operations that are 
granted and analyse that (which would be OK in this example).  But for other 
tunable options in future we may not be able to work this way.

> If you are concerned about performance, I don't think that is a problem
> either. The conditional support adds minimal overhead that is probably
> taken care of by the avc cache anyway.

I think that the issue with performance is kernel memory use.  Currently for 
FC2T2 we have 7M policydb files which roughly equates to 7M of kernel memory 
reserved, which has a huge impact on older hardware!  Most of this is due to 
compiling in support for every .te file.

For a typical machine compiling only the .te files that we need should get 
this down to around 2M.  So obviously for space the correct selection of .te 
files is a much more significant issue than booleans.  However such selection 
of .te files requires a full environment for building policy on each machine 
(which removes one of the advantages you stated for using booleans instead of 
tunables).  As configuration of policy features in ways other than removal of 
unwanted .te files becomes more popular, the volume of policy (and therefore 
size of policydb) will depend much more on such things.  I expect that in the 
not too distant future we will have a factor of 2-3 in policydb size 
determined by tunables.  If this is all done in booleans then there will be 
some significant amounts of wasted space.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
