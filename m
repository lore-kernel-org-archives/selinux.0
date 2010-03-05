Message-ID: <4B91403D.6010402@redhat.com>
Date: Fri, 05 Mar 2010 12:32:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: MLS Now working in Fedora 12/RHEL6 in Full Desktop mode.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinux-policy-3.6.32-99.fc12 on Fedora 12

I did remove setroubleshoot and abrt, since these are really not 
appropriate with an MLS machine.
Everything else is a straight install.

My account logs in as user_t.

Only AVC I am seeing now is


allow user_t xserver_t:x_screen { saver_hide saver_setattr saver_show };


I think this is caused by the screen saver kicking in.

and

#============= pulseaudio_t ==============
#!!!! This avc is a constraint violation.  You will need to add an 
attribute to either the source or target type to make it work.

allow pulseaudio_t device_t:dir read;


Which is caused because the /dev/snd directory gets created as SystemHigh.
I have no idea why.  I need to investigate who is creating the directory.

Matchpathcon says it is supposed to be SystemLow.  It must be a 
SystemHigh process that creates it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
