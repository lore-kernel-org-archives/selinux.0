Message-ID: <463A4F7C.7000302@trustedcs.com>
Date: Thu, 03 May 2007 16:09:16 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Xavier Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: launching apps at level (MLS) and polyinstantiation
References: <463243E3.2060602@gmail.com>	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>	 <463360B0.7020106@gmail.com>	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>	 <4636002F.5000100@gmail.com>	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>	 <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>	 <1178200148.3443.166.camel@moss-spartans.epoch.ncsc.mil> <1178219938.3443.209.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1178219938.3443.209.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> How about the revised patch below (only including the newrole.c and
> Makefile diffs since the hashtab code is unchanged)?  The changes from
> your patch are:
> - Make sure everything is properly enabled/disabled by USE_PAM and move
> the code into the existing USE_PAM block where appropriate.
> - Call the config file newrole_pam.conf since there could be other
> newrole config files in the future.
> - Distinguish missing config file (ok) from errors during parsing of the
> config file (should abort).
> - Remove the Authenticating <username> message since it could be
> confusing in the case where you are using a pam config that doesn't
> require it and it doesn't really provide any benefit.
> - Improve error checking and handling.
> - Coding style cleanups (indentation, comment style, etc).
> 
> To test, I created a /etc/pam.d/newrole-noauth config that had
> pam_permit.so for its auth module and created
> a /etc/selinux/newrole_pam.conf that mapped one program to
> newrole-noauth.
> 
> The alternative model would be to eliminate /etc/selnux/newrole_pam.conf
> entirely from the equation, and just have newrole look for (test via
> access()) a /etc/pam.d/newrole_<appname> config and use
> newrole_<appname> as the service name if present.

I like this idea.  I haven't had a chance to test this yet, but it looks
to be assuming that the arg to -c is just the command name without any
path info.  Should we strip that down to its basename in case someone runs
'newrole -l secret -c /usr/bin/foo' as opposed to 'newrole -l secret -c foo'?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
