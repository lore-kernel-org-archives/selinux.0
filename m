Subject: Re: Any problems with adding the following.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41FEAD91.4060205@redhat.com>
References: <41FEAD91.4060205@redhat.com>
Content-Type: text/plain
Message-Id: <1107262551.26936.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 07:55:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-31 at 17:13, Daniel J Walsh wrote:
>  /opt/.*\.so(\.[^/]*)* --      system_u:object_r:shlib_t
>  /usr/local/.*\.so(\.[^/]*)* --      system_u:object_r:shlib_t
> 
> Third party vendors do not always put sharelibaries under a "lib/" 
> directory.

Only question is whether these shared libraries should have a separate
type, so that we can limit execution of them to the third party
applications and not for any privileged applications in the base OS.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
