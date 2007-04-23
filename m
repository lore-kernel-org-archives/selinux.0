Subject: Re: adding to selinux.py
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <462CAF84.20708@gmail.com>
References: <462CAF84.20708@gmail.com>
Content-Type: text/plain
Date: Mon, 23 Apr 2007 10:09:31 -0400
Message-Id: <1177337371.24282.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 08:07 -0500, Ted X Toth wrote:
> Would it be possible to get get_ordered_context_list and get_default_context* added to selinux.py?

selinux.py is generated via swig, so you'd actually want to modify
selinuxswig.i and regenerate it.   And I think selinuxswig.i should be
reworked and split along the lines of semanageswig.i and
semanageswig_python.i over in libsemanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
