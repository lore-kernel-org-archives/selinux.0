Subject: ANN: Setools 1.5 released
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>,
   Fedora-Selinux-List <fedora-selinux-list@redhat.com>
Cc: Selinux Dev <selinux-dev@tresys.com>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 18:01:47 -0400
Message-Id: <1099087307.23756.33.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of setools is available from
http://www.tresys.com/selinux/. This is a major release with several new
features including:

- Additional options for domain transition analysis to filter the
results based on the access privileges of the target domain.

- A new tool (seaudit-report) for creating reports from SELinux log
messages. This tool is highly configurable and can effectively integrate
with the LogWatch application for automating SE Linux audit log
reporting.

- Seaudit can now export filtered log messages.

- A pair of new tools (indexcon and searchcon) for creating and
searching a snapshot of the filesystem on an SELinux system. Searchcon
allows efficient searching based on path, type, user, and/or object
class. This tool will be expanded and integrated with Apol in the
future.

- Numerous bug fixes to all of the tools.

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
