Subject: SELinux Configuration Question
To: SELinux@tycho.nsa.gov
Message-ID: <OF166CCF9D.C3ACFF49-ON85256BFF.005A0CF7@hq.caci.com>
From: "Richard Mayo" <rmayo@caci.com>
Date: Tue, 23 Jul 2002 12:38:41 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm finalizing my configuration of SELinux at my location and there's one
more change I'd like to make but haven't found a way:

I want to put all of my SELinux policy changes into new files, while
changing the default SELinux configuration as little as possible.  BTW, I'm
locked into the 31 May 2002 version for the near term -- Hopefully, that
won't make helping me difficult.

Anyway,  here's what I've got:

1)    Created /selinux/policy/types/jdw.te to define my custom file
contexts.
            This works.

2)    Created /selinux/policy/macros/program/jdw_macros.te to assign the
necessary permissions to my users.
            This works.

3)    Created /selinux/policy/file_contexts/program/jdw.fc to assign file
contexts to the appropriate files.
            This doesn't work -- the make relabel command ignores this
file, my software files are not re-typed.

4)    My work around has been to append the necessary lines from jdw.fc to
the SELinux file /selinux/policy/file_contexts/types.fc.
            This works, but strikes me as uncool.

Can anyone tell me how to configure either my SELinux data or the
compilation to use all three of my desired new file?

BTW, I've also added two lines to /selinux/policy/macros/user_macros.te to
include and then execute my macros -- no problems there.


Thanks for helping,
Rich Mayo



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
