Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n73ENo96000816
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 10:23:50 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n73EOl8m003215
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 14:24:47 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n73EN0J7005059
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 10:23:00 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n73EN0tI005057
	for selinux@tycho.nsa.gov; Mon, 3 Aug 2009 10:23:00 -0400
Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n73EJufL000325
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 10:19:56 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n73EKq8m001962
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 14:20:53 GMT
Received: by ewy7 with SMTP id 7so1147273ewy.18
        for <selinux@tycho.nsa.gov>; Mon, 03 Aug 2009 07:19:54 -0700 (PDT)
Message-ID: <4A76F20D.4090601@gmail.com>
Date: Mon, 03 Aug 2009 07:19:57 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: mina elnino <potushka@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: compiling errors!
References: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com>	 <CIEOKAFOMGPNJIPMMMAHMELCCBAA.remmolt@zwartsenberg.eu>	 <f7d5075c0907290626t1c772fd3l9f60c7a710c6152@mail.gmail.com>	 <f7d5075c0907290704x9b2b426sb6c3bb928a11a98b@mail.gmail.com>	 <1248882850.11627.64.camel@moss-pluto.epoch.ncsc.mil>	 <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>	 <1248956559.11627.105.camel@moss-pluto.epoch.ncsc.mil>	 <f7d5075c0907300632w49548c5an90f4e62aa978bb3e@mail.gmail.com> <f7d5075c0907300742q8745ec7pd17fd59677af1e86@mail.gmail.com>
In-Reply-To: <f7d5075c0907300742q8745ec7pd17fd59677af1e86@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

mina elnino wrote:
> and also when i compile the policy.conf the same error arises:
>
> $ ./obj/usr/bin/checkpolicy 
> ./rpmbuild/BUILD/serefpolicy-3.6.12/policy.conf
> ./obj/usr/bin/checkpolicy:  loading policy configuration from 
> ./rpmbuild/BUILD/serefpolicy-3.6.12/policy.conf
> policy/modules/services/hal.te":11:ERROR 'syntax error' at token 
> 'typeattribute' on line 1035303:
> #line 11
>     typeattribute hald_t daemon;
> checkpolicy:  error(s) encountered while parsing configuration
>
> is it importanr? if it is not, i'd better comment it!
>
> On Thu, Jul 30, 2009 at 6:02 PM, mina elnino <potushka@gmail.com 
> <mailto:potushka@gmail.com>> wrote:
>
>     to build it:
>
>     $ make conf
>     $ make policy
>
>     the second make made an error (in the attached file).
>     and also it generated policy.conf
>
>
>     On Thu, Jul 30, 2009 at 4:52 PM, Stephen Smalley
>     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>> wrote:
>
>         On Thu, 2009-07-30 at 09:51 +0430, mina elnino wrote:
>         > well, i have to say that i went through the steps in:
>         >
>         > http://danwalsh.livejournal.com/26428.html
>         >
>         > and at last i realized that this page is for the ones who
>         want to make
>         > policies from the source. now i have packages:
>         >
>         > $ ls ~/rpmbuild/RPMS/noarch/
>         > selinux-policy-3.6.12-62.fc11.noarch.rpm
>         > selinux-policy-doc-3.6.12-62.fc11.noarch.rpm
>         > selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm
>         > selinux-policy-mls-3.6.12-62.fc11.noarch.rpm
>         > selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm
>         >
>         > none of them is the source policy package. i mean i need
>         that old m4
>         > macros, "*.te" files and "policy.conf" which could be
>         installed by
>         > "selinux-policy-targeted-source" or
>         "selinux-policy-strict-source" in
>         > fc4.
>
>         If you want to just unpack the source tree along with any
>         Fedora-specific patches applied, you can do:
>         rpm -i selinux-policy*.src.rpm
>         cd ~/rpmbuild/SPECS
>         rpmbuild -bp selinux-policy.spec
>         cd ../BUILD/serefpolicy*
>         Then you can build it in the usual manner.
>
>         You can also clone the upstream refpolicy repository if you want:
>         git clone http://oss.tresys.com/git/refpolicy.git
>         cd refpolicy
>
>         Note however that Fedora policy is built modular rather than
>         monolithic,
>         so there is no policy.conf file per se.  But if you run make
>         with the
>         default build.conf, you'll end up with a policy.conf file.
>
>         --
>         Stephen Smalley
>         National Security Agency
>
>
>
I think this might be due to checkpolicy
being built with not a certain *.h file, or lib.
(but could be wrong).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
