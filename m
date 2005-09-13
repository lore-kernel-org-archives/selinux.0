Message-ID: <43271BDA.3060403@redhat.com>
Date: Tue, 13 Sep 2005 14:35:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: New ideas on implementation on libsetrans.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After some discussion, we want to change the translation library into a 
long running daemon with a unix domain socket that libselinux can talk 
to for translation.  This eliminates the need to use dlopen, and link 
with -dl. 

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
