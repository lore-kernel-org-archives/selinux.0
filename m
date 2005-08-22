Message-ID: <4309D9BA.30802@trustedcs.com>
Date: Mon, 22 Aug 2005 08:57:14 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Prakash Saivasan <helloprak@yahoo.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: info on Security enhanced X server
References: <20050819111115.59790.qmail@web54401.mail.yahoo.com> <1124455064.32663.30.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124455064.32663.30.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-08-19 at 12:11 +0100, Prakash Saivasan wrote:
> 
>>Hi,
>>    Can anyone let me know where I can find source
>>code that enhances X
>>windows security ( changes to X-Server that implements
>>enforcement of
>>SE-Policy ) ?
> 
> 
> Snapshots of the patches are available from 
> http://home.insightbb.com/~dgoeddel/
> But I'm not sure whether they are the latest.
> 

The patches are currently getting a bit stale.  We have discussed
the patches with Jim Gettys (of X fame) and everyone thought it
would be best update the patches after the major release of X.org
that is in the works.  The patches should then go through reviews
and be put forward for inclusion into the X.org mainline.  I'll post
when there are updates to the patches.  Hopefully, everyone will not
have to wait too long after the X.org release - we'll see how much
needs to be changed  :)

I'm told that the new patches will also have a few bug fixes and some
improved functionality.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
