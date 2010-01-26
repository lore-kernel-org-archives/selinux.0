Subject: Re: access decision API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 26 Jan 2010 16:34:01 -0500
Message-Id: <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-27 at 00:50 +0330, michel m wrote:
> Hi,
> I have some data in userspace that I am keeping its security
> context.but as I want to write this data on some file in OS, I need to
> consult with security server if such data is allowed to be written on
> the file.
> I would like to know if there is any API that let me do such a
> scenario, that is input source and destination security context (both
> of them security context,not a domain context) and returns access
> decision. I am familiar with avc_has_perm(3), but seems to be not
> correct solution because it gets domain context as the first argument.

avc_has_perm() can be used with any pair of security contexts.  Typical
usage is to pass the security context of a subject/process as the first
argument, but not always (e.g. there are some permission checks that
control inter-object relationships), and that is not a requirement.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
