From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
Date: Thu, 28 Feb 2008 16:17:16 -0500
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <47C2CC18.6080801@redhat.com> <47C701E8.1030603@tycho.nsa.gov> <1204224665.31790.179.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1204224665.31790.179.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802281617.17223.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 February 2008 13:51:05 Stephen Smalley wrote:
> On Thu, 2008-02-28 at 13:48 -0500, Eamon Walsh wrote:
> > Stephen Smalley wrote:
> > > On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
> > >> Eamon Walsh wrote:
> > >>> The X object manager logs all avc's and status messages (including
> > >>> the AVC netlink stuff) through the audit system using libaudit calls
> > >>> (audit_log_user_avc_message, etc.)

Please tell me they have different record types. Also do you have any samples 
that we can look over to make sure they conform?


> > > Can you verify that the X server was able to create the audit socket
> > > successfully?
> >
> > Yes, because when I actually install the audit package, things started
> > appearing in /var/log/audit/audit.log.  I did not have the audit package
> > installed.  Why isn't it redirecting to /var/log/messages in this case?

It should be if you have audit enabled. Perhaps you didn't boot with audit=1?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
