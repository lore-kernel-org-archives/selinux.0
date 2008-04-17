Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HHpDXn013113
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:51:13 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HHpC88023873
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 17:51:12 GMT
Received: by wr-out-0506.google.com with SMTP id c30so204311wra.21
        for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 10:50:58 -0700 (PDT)
Message-ID: <cadfc0e40804171050p6c4bbae9m134c1bf81542321a@mail.gmail.com>
Date: Thu, 17 Apr 2008 12:50:55 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Fwd: adding a new security class
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1208452550.18883.400.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <1208438080.18883.361.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170720q56eb623bn22dc7b7af31f671c@mail.gmail.com>
	 <1208442613.18883.386.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170822n2ff34af1lcc92aa2c0a1cfff2@mail.gmail.com>
	 <1208446196.18883.394.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170855q25d3e24fw61fa1a45b874c98@mail.gmail.com>
	 <1208447943.18883.396.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170933r63ebccd1w14df5c1efb78f697@mail.gmail.com>
	 <1208452550.18883.400.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 17, 2008 at 12:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>  On Thu, 2008-04-17 at 11:33 -0500, Xavier Toth wrote:
>  > This te file is not the finally resting place for copy/paste policy
>  > simply a convenient place to try out the class.
>  >
>  > [tedx@comms hack-policy]$ make rebuild
>  > rm -f /home/tedx/src2/Linux_i386/OED/policy/hack-policy.pp
>  > rm -f *.CKP *.ln *.o core errs ,* *~ .emacs_* tags TAGS make.log *.i
>  > if [ ! -d /usr/share/selinux/devel/include/jcdx ]; then \
>  >               sudo mkdir /usr/share/selinux/devel/include/jcdx; \
>  >               sudo chmod 777 /usr/share/selinux/devel/include/jcdx; \
>  >       fi; \
>  >       cp hack-policy.if /usr/share/selinux/devel/include/jcdx;
>  > rm -f /usr/share/selinux/devel/include/jcdx/hack-policy.if
>  > make -f /usr/share/selinux/devel/Makefile
>  > make[1]: Entering directory `/home/tedx/src2/hack-policy'
>  > Compiling mls hack-policy module
>  > /usr/bin/checkmodule:  loading policy configuration from tmp/hack-policy.tmp
>  > hack-policy.te":30:ERROR 'unknown class x_application_data used in
>  > rule' at token ';' on line 3343:
>  > allow x_rootwindow_t self:x_application_data paste_without_confirm;
>  > ;
>  > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>  > make[1]: *** [tmp/hack-policy.mod] Error 1
>  > make[1]: Leaving directory `/home/tedx/src2/hack-policy'
>  > make: *** [progs] Error 2
>
>  You need a
>  require {
>         class x_application_data { paste_without_confirm };
>  }
>  statement in your module or one of the interfaces it uses.
>
>  policy_module() only automatically imports requires for the kernel
>  classes and perms, I think.
>
>
>  --
>
>
> Stephen Smalley
>  National Security Agency
>
>

That did it, thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
