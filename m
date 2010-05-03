Subject: Re: /etc/initscript breaks SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
In-Reply-To: <p2vdd18b0c31005022154obbc1db15s4e01c5821bf7baa2@mail.gmail.com>
References: <p2vdd18b0c31005022154obbc1db15s4e01c5821bf7baa2@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 03 May 2010 12:31:25 -0400
Message-Id: <1272904285.20339.82.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-05-02 at 21:54 -0700, Justin Mattock wrote:
> I've been racking my brain for the last few days on
> this one, and seem(for the life of me), have no solution.
> 
> at first thought this was opensuse specific, but it's not
> i.g. my cblfs systems hit this as well(if not all systems at that).
> 
> when adding /etc/initscript somehow SELinux can't figure how to
> transistion with the whole SHELL -c thing.
> 
> under init.c #800(sysvinit-2.85)
> the code is this:
> 
>  /* See if there is an "initscript" (except in single user mode). */
>   if (access(INITSCRIPT, R_OK) == 0 && runlevel != 'S') {
> 	/* Build command line using "initscript" */
> 	args[1] = SHELL;
> 	args[2] = INITSCRIPT;
> 	args[3] = ch->id;
> 	args[4] = ch->rlevel;
> 	args[5] = "unknown";
> 	for(f = 0; actions[f].name; f++) {
> 		if (ch->action == actions[f].act) {
> 			args[5] = actions[f].name;
> 			break;
> 		}
> 	}
> 
> 
> any ideas why SELinux gets confused with this, and
> doesn't want to transistion?

In the above code, you are exec'ing the shell and just passing the
script as an argument, not exec'ing the script.  So you need a domain
transition on the shell rather than the script, or you need to perform a
setexecon() in the code.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
