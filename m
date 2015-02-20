Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1K7X911031895
 for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2015 02:33:09 -0500
Received: by mail-wg0-f43.google.com with SMTP id z12so11604960wgg.2
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 23:33:06 -0800 (PST)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id dx11sm37860733wjb.23.2015.02.19.23.33.05
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 19 Feb 2015 23:33:05 -0800 (PST)
Date: Fri, 20 Feb 2015 08:33:03 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150220073302.GA10579@linksys-wireless-usb.network2>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
 <20150220020213.GG12937@tracyreed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20150220020213.GG12937@tracyreed.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Feb 19, 2015 at 06:02:13PM -0800, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 04:34:25PM PST, Tracy Reed spake thusly:
> > # semanage login -l
> 
> Ok, part of my confusion here is that I've been confusing semanage login with
> semanage user. It's been a while since I've dealt with SELinux. I understand
> that semanage login -l shows what Linux users map to what selinux users:

Right, this table (login table) shows the associations of selinux identities and selinux securtity levels with linux users, whereas the "user table" shows
associations of selinux roles and security levels with selinux users.

> 
> > Login Name                SELinux User              MLS/MCS Range            
> > 
> > __default__               unconfined_u              SystemLow-SystemHigh     
> > p16001                    p16001_u                  p16001                   
> > p16002                    appuser_u                 s0:c1.c499-s0:c2         
> > p16003                    appuser_u                 s0:c1.c499-s0:c3         
> > p16004                    unconfined_u              s0-s0:c0.c1023,c4        
> > p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5     
> > p16006                    unconfined_u              s0-s0:c0.c1023,c6        
> > p16007                    unconfined_u              s0-s0:c0.c1023,c7        
> > p16008                    unconfined_u              s0-s0:c0.c1023,c8        
> > p16009                    unconfined_u              s0-s0:c0.c1023,c9        
> > root                      unconfined_u              SystemLow-SystemHigh     
> > system_u                  system_u                  SystemLow-SystemHigh  
> 
> So we are mapping p16002 to appuser_u but appuser_u doesn't exist at the
> moment. But what's with the MLS/MCS range column?  Is this saying p16002 has
> categories s0:c1.c499-s0:c2 is it saying appuser_u (selinux user) has
> categories s0:c1.c499-s0:c2? Given that the selinux user is the same but the
> categories listed are different for Linux login users p16002 and p16003 I would
> think it is saying those categories go with those Linux login users.

> 
> How/why is it different from the output of semange user -l ?
> 
> # semanage user -l
> 
> Labeling   MLS/       MLS/                          
> SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles
> 
> git_shell_u     user       SystemLow  SystemLow                      git_shell_r
> guest_u         user       SystemLow  SystemLow                      guest_r
> p16001_u        user       SystemLow  p16001                         user_r
> p16002_u        user       SystemLow  p16002                         user_r
> root            user       SystemLow  SystemLow-SystemHigh           staff_r sysadm_r system_r unconfined_r
> staff_u         user       SystemLow  SystemLow-SystemHigh           staff_r sysadm_r system_r unconfined_r
> sysadm_u        user       SystemLow  SystemLow-SystemHigh           sysadm_r
> system_u        user       SystemLow  SystemLow-SystemHigh           system_r unconfined_r
> unconfined_u    user       SystemLow  SystemLow-SystemHigh           system_r unconfined_r
> user_u          user       SystemLow  SystemLow-SystemHigh           user_r
> xguest_u        user       SystemLow  SystemLow                      xguest_r

> 
> Here there are no Linux users involved, only selinux users it seems, which is
> fine. But it shows p16001_u with range  p16001 and p16002_u with p16002.
> 
> And that is different yet with respect to the output of the chcat command:
> 
> # chcat -L -l p16001 p16002
> p16001: s0:c0.c1023
> p16002: s0:c0.c1023
> 
> This says p16001 and p16002 have access to all categories.
> 
> So...who is right?
> 
> Also, I'm still trying to figure out how to dig myself out of this hole:
> 
> # semanage user -a -R user_r appuser_u
> libsemanage.validate_handler: selinux user appuser_u does not exist (No such file or directory).
> libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u, s0:c1.c499-s0:c2)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No such file or directory).
> /usr/sbin/semanage: Could not commit semanage transaction
> 
> This would seem to be a paradox or chicken and egg problem.

You are misunderstanding the concept of associating things with "selinux users" (user table) versus the concept of associating things with "linux users" (login table), and how the two relate.

You cannot associate something with a Linux user if that something is not associated with the SELinux user first.

For example the error message above complains that you have a "appuser_u" identity associated with some "linux user(s)" (p16002, p16003). Howver that identity (appuser_u) does not exist in your "user table". 

So to fix that error: re-add the appuser_u selinux user to the "user table" , then remove the references to "appuser_u" from the "login table" *first* , and then finally remove the appuser_u association from the "user table" again.


> 
> Ideas? Thanks! :)
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

iQGcBAEBCgAGBQJU5uMpAAoJENAR6kfG5xmcwaQL/jC8VhAXBKpcOdVUuqvOvCUz
zwBOfJzT0wSbyUQeVnJKcxylp3yrIrY//KuA4KWYLCssHzqASUCRoCmyXK0EPPEh
Rhupour+fS5QK6//CmH+ZnXR5JSAsJgREUgck05UIuY+pEG6OwFFB2htNtFdTe0t
Dva35dHKFRWWuoUJ/Ri8S/3/mdsDsy/p8hXHAL22wKvDYq9nLv04E2nMWvtfv8uJ
wuNuuRwRGehu+QsA07PnpOqvSKhnO53ys+CpQFwGN+uMJBiYYbN1tLeU5uxX4Uvz
xAuEygJYpHiI2Glw0ZClK0UqiSFYp1P1K4j29Ya6h7DETexr+1HAhIf82Lj+x+UD
0P1oMjEIE4B0IjPl1VuVBTclwwdg40JKL7qG72YUiHmV8dBpfsXUAGNT8721QaCu
7s66uS+iJHgV/5ymLlCnXUWG1UWhDJcpBwg0qB2X8bqe3oMFp5dGeOgB5qUOPspF
Vb4VRtxtjzKJcKf184HSDjJMQuY4SWNFX0WUDrX/Aw==
=RGed
-----END PGP SIGNATURE-----
