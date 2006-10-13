Subject: Re: context_sensitivity_{get|set}
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Matt Anderson <mra@hp.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <20061013165831.49220.qmail@web36602.mail.mud.yahoo.com>
References: <20061013165831.49220.qmail@web36602.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 14:47:14 -0400
Message-Id: <1160765234.14346.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-13 at 09:58 -0700, Casey Schaufler wrote:
> 
> --- Matt Anderson <mra@hp.com> wrote:
> 
> 
> > For my usage I need the entire low level.  There may
> > be other users want
> > just the sensitivity, but I'd be concerned that
> > information would be
> > unintentionally downgraded by leaving off
> > categories.
> 
> This has got to stop. Sensitivity has ALWAYS
> refered to the entire sensitivity label,
> heirarchical and categories combined. You
> never ever deal with them seperately, in
> code or in dialog. I know of exactly one
> exception to this rule, and the current
> project remains innocent of it. I'm not going
> to be the serpent in the garden and tell
> you what it is, either.
> 
> Level is the hierarchical component.
> Categories or compartments describe
> the non-hierarchical component.
> Sensitivity is the combination of
> at least those two parts.
> 
> Always.

No, usage is decidedly mixed.  "Security level" is often used to mean
the entire label, while "sensitivity" is often used to mean the
hierarchical component only (and this fits more with the natural
language meaning of sensitivity).  Look around a bit.

In any event, in SELinux, each context has a MLS range consisting of a
low level and a high level (reduced to a single level when they are
equal), and each level consists of a sensitivity value and an optional
category set.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
