Message-ID: <45DE0C91.5010305@mentalrootkit.com>
Date: Thu, 22 Feb 2007 16:35:13 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 2/2] sepolgen: handle the latest reference policy
References: <45DC8C04.5060909@mentalrootkit.com> <1172155250.14363.367.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172155250.14363.367.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-02-21 at 13:14 -0500, Karl MacMillan wrote:
>> Update the sepolgen parser (refparser.py) to handle the latest reference 
>> policy. Includes some other parser cleanups.
>>
>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
> Running sepolgen-ifgen on up-to-date fc6 after applying these patches
> yields numerous errors of the form:
> could not parse text: "Syntax error on line 1 gnome_file_dialog
> [type=IDENTIFIER]"
> 

This appears to be caused by the characters "pp" being inserted at the 
beginning of that line in mozilla.if. Yet another error that would be 
caught by a real compiler for the reference policy.

The rest of the errors, unfortunately, are simply the parser ending up 
in an inconsistent state after the parser error. I've been trying to 
track down this problem for a while with no success.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
