Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB3GUM3U012124
	for <selinux@tycho.nsa.gov>; Sat, 3 Dec 2011 11:30:22 -0500
Received: from nm3.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id pB3GUKTM009816
	for <selinux@tycho.nsa.gov>; Sat, 3 Dec 2011 16:30:21 GMT
Message-ID: <1322929819.82046.YahooMailClassic@web87016.mail.ird.yahoo.com>
Date: Sat, 3 Dec 2011 16:30:19 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: CIL/SELinux Userspace Integration
To: Steve Lawrence <slawrence@tresys.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve,

Thanks for this, it seems to work fine with the policy samples I've been 
using. I've had a couple of minor problems though:

1) A macro does not work with permissionset as one of the parameters (all 
   the other parameters worked okay).

2) Macro comments are not permitted. I notice they are not present in the 
   test files so has it been dropped.

3) I could not find a way to generate the policy.conf file. I set the
   DEBUG=1 in the CIL Makefile like I used to but no file.

4) To set deny_unknown in secilc.c required a 'U' in the getopt line: 
         getopt_long(argc, argv, "hvtU:MDc:", .....

5) I could not load a new policy that had a boolean and supporting
   statements in it. The actual binary policy was fine (using apol), but
   load_policy had problems. I started with a Fedora 16 base and added 
   the new Integration code with no problems. Is it a known problem as 
   if not I'll check further. 
   The errors I had when running semodule with a boolean were (Note: I 
   had already built a new base policy (SELINUXTYPE=rch-test1) with no
   problems):

                      ------ Start --------------
# semodule -i base.cil ext_gateway.cil int_gateway.cil move_file.cil

SELinux:  Could not load policy file /etc/selinux/rch-test1/policy/policy.26:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
SELinux:  Could not load policy file /etc/selinux/rch-test1/policy/policy.26:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
semodule:  Failed!
                    ----- End -----------------

Richard


--- On Tue, 22/11/11, Steve Lawrence <slawrence@tresys.com> wrote:

> From: Steve Lawrence <slawrence@tresys.com>
> Subject: CIL/SELinux Userspace Integration
> To: "SELinux" <selinux@tycho.nsa.gov>
> Date: Tuesday, 22 November, 2011, 22:00
> As many of you may know, we have been
> working on CIL for a while now.
> This has been posted to the list many times before, so
> we'll just post
> the link to the wiki for now [1], but we're happy to answer
> any questions.
> 
> In addition to adding numerous features to CIL since we've
> last posted
> to the list, we've also been working hard at integrating
> CIL
> into SELinux userspace. We now have that in a state that's
> ready for
> comments and review.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
