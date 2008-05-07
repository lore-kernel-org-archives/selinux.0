From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
Date: Wed, 7 May 2008 14:45:46 -0400
Cc: linux-audit@redhat.com, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil> <200805071248.13439.sgrubb@redhat.com> <1210180842.6434.98.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1210180842.6434.98.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200805071445.47044.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 07 May 2008 13:20:42 Stephen Smalley wrote:
> then we'd need to define two new fields, one to correspond
> to the real/raw context string corresponding to the scontext and one to
> correspond to the real/raw context string corresponding to the tcontext.
> And they would only be present if the scontext and/or tcontext happened
> to be invalid under current policy.  Maybe "rscontext" and "rtcontext"
> if we don't think that will confuse existing userspace

Sounds good to me. I don't think either names you mentioned are taken.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
