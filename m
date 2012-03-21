Subject: Re: SEAndroid init.rc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?UTF-8?Q?=E4=B9=9C=E8=81=9A=E8=99=8E?= <niejuhu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAL=jxq04myXmTrx7fs-Bg+cHMC9U9SaiXQpvkN5sotWFcY77MA@mail.gmail.com>
References: 
	 <CAL=jxq04myXmTrx7fs-Bg+cHMC9U9SaiXQpvkN5sotWFcY77MA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 21 Mar 2012 10:12:30 -0400
Message-ID: <1332339150.27512.38.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-21 at 21:23 +0800, 乜聚虎 wrote:
> Hi,
> I was reading the SEAndroid code and I got confused about something. 
> There are some restorecon commands like 'restorecon /dev' in the
> init.rc file. I don't know 
> which files or folders should be 'restorecon' and why. Can anybody
> help me? 

/dev and /dev/socket are created by init before the policy is first
loaded and thus need to have their security context restored prior to
starting ueventd.

Some of the directories are created by init.rc (e.g. on first boot or
after a factory reset) and thus we must perform a restorecon to ensure
that they get the correct security context if they have a different
security context than the parent directory. It is analogous to the
existing chown/chmod commands, but only where we want to make a
distinction for the policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
