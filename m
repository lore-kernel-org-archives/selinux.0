Subject: Re: issue on confidentiality
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041022163800.63917.qmail@web51507.mail.yahoo.com>
References: <20041022163800.63917.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098463657.7614.253.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 12:47:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-22 at 12:38, Park Lee wrote:
>      As we know that the information security mainly include the
> aspects of confidentiality, integrity,availability...etc. The TE model
> is mainly used to protect the integrity. Then, if we don't MLS, which
> model is used to protect the confidentiality in SELinux? and how it is
> protected?

TE can protect confidentiality, and does so for certain kinds of
resources in the example policy (e.g. /etc/shadow, per-domain temporary
files, etc).  You can actually express a MLS policy via a TE
configuration; it just starts to explode the type space if you have a
large number of levels.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
