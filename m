Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAA01nlA031181
	for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2009 19:01:49 -0500
Received: from mail55.messagelabs.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAA03nJO028126
	for <selinux@tycho.nsa.gov>; Tue, 10 Nov 2009 00:03:49 GMT
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id nAA01lkd020447
	for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2009 17:01:47 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id nAA01lv8006629
	for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2009 18:01:47 -0600 (CST)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id nAA01l0s006626
	for <selinux@tycho.nsa.gov>; Mon, 9 Nov 2009 18:01:47 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Where do I get a good Policy Base ?...
Date: Mon, 9 Nov 2009 19:01:24 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D07909698@de01exm68.ds.mot.com>
In-Reply-To: <1256633374.3090.13.camel@localhost>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com> <4AD9AD06.9030309@redhat.com> <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com> <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil> <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com> <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil> <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com> <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com> <1256633374.3090.13.camel@localhost>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Dominick Grift" <domg472@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your answers   :-)

A quick follow up question...

What would be the most appropriate Fedora selinux-policy that I can
start off with as a base to build on top of, Given:

that I have Linux 2.6.27,  and I have the following latest SELinux
package versions :

> checkpolicy-2.0.19
> libselinux-2.0.85
> libsemanage-2.0.33
> libsepol-2.0.37
> policycoreutils-2.0.69
> sepolgen-1.0.17

Should I use Fedora 11 -   
download.fedora.redhat.com/pub/fedora/linux/development/i386/os/Packages
/selinux-policy-3.6.6-5.fc11.noarch.rpm

Or should I use Fedora 10 - 
download.fedora.redhat.com/pub/fedora/linux/updates/10/i386/selinux-poli
cy-3.5.13-45.fc10.noarch.rpm

Or should I use new RefPolicy from OpenSuSE -
ftp5.gwdg.de/pub/opensuse/repositories/security:/SELinux/openSUSE_Factor
y/noarch/selinux-policy-refpolicy-standard-2.20081210-1.8.noarch.rpm


Thanks in advance as usual for all your help.


-----Original Message-----
From: Dominick Grift [mailto:domg472@gmail.com] 
Sent: Tuesday, October 27, 2009 3:50 AM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov
Subject: Re: Where do I get a good Policy Base ?...

On Mon, 2009-10-26 at 21:16 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I used to have the following SELinux related package versions on my 
> Linux (2.6.18) system:
> 
> Checkpolicy      - 1.33.1
> Libselinux       - 2.0.13
> Libsemanage      - 2.0.1
> Libsepol         - 2.0.3
> Libsetrans       - 0.1.18
> Policycoreutils  - 2.0.16
> 
> And I used a 'strict' Base policy from Fedora Core 6. Made the 
> modifications I needed on top of that, and I was very happy...
> 
> 
> We get our OS packaged/delivered from a third party company, and we're

> upgrading to Linux 2.6.27, and as part of this upgrade, we are also 
> migrating to much newer versions of the SELinux packages. They are:
> 
> checkpolicy-2.0.19
> libselinux-2.0.85
> libsemanage-2.0.33
> libsepol-2.0.37
> policycoreutils-2.0.69
> sepolgen-1.0.17
> 
> 
> My questions are:
> 
> 1. I believe the "strict" policy is no longer supported in the above 
> versions of SELinux packages? Is this true ?

the "strict" policy model is no longer supported. The strict and target
policy have merged to a policy model that is called "targeted". You can
configure the "targeted" policy to behave like old strict policy by
removing removing the unconfined modules and by mapping your Linux
logins to strict SELinux users.

> 
> 2. The entire set of policies that I have fine-tuned over the years 
> under my  /etc/selinux/strict/modules/active/modules/*.pp  directory 
> in my previous older system, can I make any use of that ?? In other 
> words, can that stuff be re-used at all ? Or do I need to develop 
> policy from scratch again ?

I am not sure about this but my opinion is that it should  in most cases
be possible to use older binary modules in newer policy. Reference
policy should be compatible in my view.

Please note though that is encouraged to keep the source policy for your
binary modules so that you can edit policy modules easily later.
> 
> 3. What will be a good base policy for me to start policy development 
> on ? Will it be refpolicy, or should I grab the base 'targeted' policy

> from fedora core 11 for example ?

This depends on your distro, but generally you should be better of with
a distro specific policy. Also keep in mind that Fedora has a active
community, frequent updates and many testers.

> 
> 4. Assuming 'strict' is no longer supported in the NEW package 
> versions above, and I use a base 'targeted' policy as my starting 
> point... Should I be able to simply remove the "unconfined.pp" policy 
> module from the base targeted policy, and that essentially turns my 
> system into "strict-like" mode ? Is that advisable ?

That is the idea, yes,

> 
> 5. If I do continue to use the 'targeted' base policy as is, how can I

> develop policy on top of that, to make sure I still block specific 
> things that I don't want to take place. For example, I DON'T want a 
> user_t to be able to write to files of type  etc_t  for example. How 
> do I go about accomplishing this  given the 'targeted' framework ? I 
> know how to do this in the old 'strict' framework, not sure how to go 
> about it with the targeted framework. Please shed some light or point 
> me to documents...

You can write your own custom policy modules on that of the policy that
is distributed. Current policy is usually modular. Basically write a
source policy module, build it and install it using the semanage or the
semodule command.

e.g. (Fedora/RedHat):

echo "policy_module(mytest, 0.0.1)" > mytest.te; make -f
/usr/share/selinux/devel/Makefile mytest.pp; sudo semodule -i mytest.pp
sudo semodule -l | grep mytest

> 
> Again, Any references or documentation links would be greatly 
> appreciated.

www.selinuxproject.org/page/User_Resources
> 
> Thanks in advance.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
quotes as the message.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
