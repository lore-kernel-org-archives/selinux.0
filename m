Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1LD7btK011156
 for <selinux@tycho.nsa.gov>; Sat, 21 Feb 2015 08:07:37 -0500
Received: by mail-wi0-f175.google.com with SMTP id r20so8193375wiv.2
 for <selinux@tycho.nsa.gov>; Sat, 21 Feb 2015 05:07:34 -0800 (PST)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id lu13sm6908346wic.10.2015.02.21.05.07.32
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 21 Feb 2015 05:07:33 -0800 (PST)
Date: Sat, 21 Feb 2015 14:07:31 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150221130730.GA19012@linksys-wireless-usb.network2>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
 <20150220020213.GG12937@tracyreed.org>
 <20150220073302.GA10579@linksys-wireless-usb.network2>
 <20150220232749.GM12937@tracyreed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20150220232749.GM12937@tracyreed.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Feb 20, 2015 at 03:27:50PM -0800, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 11:33:03PM PST, Dominick Grift spake thusly:
> > Right, this table (login table) shows the associations of selinux identities
> > and selinux securtity levels with linux users, whereas the "user table" shows
> > associations of selinux roles and security levels with selinux users.
> 
> Ok, I think I understand that now... Looks like they both can associate
> security levels with their respective kinds of users. Seems odd now to be able
> to associate security levels with Linux users instead of just SELinux users. 
> 
> Now I am wondering which one takes precedence. For example, in the MCS setup I
> am attempting do I need to have the security category defined in the login
> table or the user table or both?
> 
> > You are misunderstanding the concept of associating things with "selinux
> > users" (user table) versus the concept of associating things with "linux
> > users" (login table), and how the two relate.
> 
> Indeed.
> 
> > You cannot associate something with a Linux user if that something is not
> > associated with the SELinux user first.
> 
> Ok...
> 
> > For example the error message above complains that you have a "appuser_u"
> > identity associated with some "linux user(s)" (p16002, p16003). Howver that
> > identity (appuser_u) does not exist in your "user table". 
> > 
> > So to fix that error: re-add the appuser_u selinux user to the "user table" ,
> > then remove the references to "appuser_u" from the "login table" *first* ,
> > and then finally remove the appuser_u association from the "user table"
> > again.
> 
> Your use of "*first*" in the second step is confusing to me but it looks like
> the order of operations here is:
> 
> 1. re-add the appuser_u selinux user to the "user table"
> 
> 2. remove the references to "appuser_u" from the "login table"
> 
> 3. remove the appuser_u association from the "user table"

Yes the above stepp you have done the trich.

semanage is such a lousy tool in my view, it should not have let you remove the user mapping in the first place if there were references to it in the login table (i.e. if there are login mapping that rely on the selinux user.)

I suppose you could resort to doing it manually by editing files in /etc/selinux. (/etc/selinux/targeted/seusers and some seusers.local file elsewhere which is the one that is actually maintained by libsemanage)

I do not use those tools, as i manually maintain /etc/selinux. So i can't really be of much help here.

> 
> 
> So to do step 1 and re-add appuser_u selinux user to the "user table" I should do this and get this result:
> 
> # semanage user -a -R user_r appuser_u
> libsemanage.validate_handler: selinux user appuser_u does not exist (No such file or directory).
> libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u, s0:c1.c499-s0:c2)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No such file or directory).
> /usr/sbin/semanage: Could not commit semanage transaction
> 
> Even if I try step 2 first (in case that's what you meant by *first) I get this:
> 
> # semanage login -d p16002
> libsemanage.validate_handler: selinux user appuser_u does not exist (No such file or directory).
> libsemanage.validate_handler: seuser mapping [p16003 -> (appuser_u, s0:c1.c499-s0:c3)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No such file or directory).
> /usr/sbin/semanage: Could not commit semanage transaction
> 
> What am I missing here? Thanks!
> 
> -- 
> Tracy Reed



> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJU6IMOAAoJENAR6kfG5xmcdxAMAMUsfti3W6I/0SKopcHDil24
qEQdyUTvw7L1G/nva/ikDKV/ZJrEXNOiDY0h7nXWHpFeLhMG0MhdkVKDBxw1+D0j
MUc82sZmS/AjXoj3iWf2U/NrZYbnpC1qvZm6abeU2x/Oyb8pfmYO0sP/67R3wSdM
Ii6SpsATzBwJHvdq7BA9YmQE98gaQPRxIQn1boJYCxvOaNnyf25+sRAdDiKSfp1r
w9toTfaxNnjrPWbFxb73pDxtsGfVkbzX+twv8fs+045rWdsYazh8lhZZVMylEJ1C
QNPKjmzqwxr+34bXIjEFwKXIYfkPBWrxGn4nsLuXcRkvD5RyDA9Mi9hRKTB/TC+f
BWEgQ+UiGbACtYiaTYu4veCTiLHNVK/iUOoEUQNwlcLVczCGUKqJeDF3voOtuBD/
n9wbiLvFfV3x4GI36xeMCbWE7XsQU3erPoN1ZVkEp8BvBOSmDhLVKr68y0sRTu6v
GI0K/TjVHdT8+RmhClyMD3WScQ48xDKJ6gNYyJu8GQ==
=oMTr
-----END PGP SIGNATURE-----
