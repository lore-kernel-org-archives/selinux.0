MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: SELinux and SSH Timers ?...
Date: Thu, 3 Sep 2009 16:17:53 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0731CB89@de01exm68.ds.mot.com>
In-Reply-To: <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil>
References: <4A996106.4060604@martinorr.name> <87my5ijji4.fsf@anzu.internal.golden-gryphon.com> <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil> <4A9BCE45.7060704@martinorr.name> <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil> <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name> <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil> <4A9E6406.5000501@martinorr.name> <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil> <4A9F90B1.3000908@martinorr.name> <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I have defined policy such that user_t cannot 'write' to certain
files/directories, e.g.  /etc/passwd.

I have Selinux Strict policy running in "Permissive" Mode, and lets just
say I am not at liberty to run it in "Enforcing" mode.

I also have  /selinux/avc/cache_threshold set to the default  "512".

And to test that my policy works, I SSH-login as a user "test" who has
default context  user_u:user_r:user_t
And I attempt to "vi /etc/passwd".

Given the above conditions: 
- I understand that SELinux will (and does) report a deny into audit.log
the first time I attempt the "vi /etc/passwd".

- The next time I do "vi /etc/passwd" within the same SSH-session, it
does NOT log the deny! I understand this is because of the Permissive
Mode + the cache_threshold value.

- If I exit my SSH session, and then create a new SSH-session and login
again with user "test", and then "vi /etc/passwd" again, I thought I
should see a deny in the audit.log ? Since this is a new SSH-Session...
But I DON'T see it ???

- If I however SSH-login as "test" after a 'long' time, may be a few
hours, and then "vi /etc/passwd", then I do see the deny again...

So my question is: Is there a default timer somewhere (may be for SSH),
during which duplicate audit denies don't get logged ? And perhaps after
the timer expires, previous denies are eligible for reporting again ?

What would be the impact of changing the "cache_threshold" to "5" for
example as opposed to the default '512' ?

Hopefully that wasn't too confusing.  Thanks in advance for your help
:-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
