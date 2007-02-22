Subject: Re: [PATCH 2/2] sepolgen: handle the latest reference policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <45DC8C04.5060909@mentalrootkit.com>
References: <45DC8C04.5060909@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 09:40:50 -0500
Message-Id: <1172155250.14363.367.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-21 at 13:14 -0500, Karl MacMillan wrote:
> Update the sepolgen parser (refparser.py) to handle the latest reference 
> policy. Includes some other parser cleanups.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Running sepolgen-ifgen on up-to-date fc6 after applying these patches
yields numerous errors of the form:
could not parse text: "Syntax error on line 1 gnome_file_dialog
[type=IDENTIFIER]"

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
