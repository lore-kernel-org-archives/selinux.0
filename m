Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8304ACC384@eammlnt051.lmc.ericsson.se>
From: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>
To: "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: terminals permissions
Date: Tue, 15 Oct 2002 13:43:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'm trying to give to some domains access to terminal writing... without
success.

In "enforcing" mode, when I execute ifconfig or ping nothing is written to
the current terminal in answer.  Is that normal behavior ?

How can I give my applications permission to write to the terminal.

Thank You,

Eric Gingras

PS: I've try :
               allow ifconfig_t sysadm_tty_device_t:chr_file rw_file_perms;
               allow ifconfig_t sysadm_devpts_t:chr_file rw_file_perms;

 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
