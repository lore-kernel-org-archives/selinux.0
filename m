From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com
Subject: three patches to external/sepolicy
Date: Thu, 19 Jul 2012 14:49:20 -0700
Message-Id: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[PATCH 1/3] external/sepolicy: the media apps from third-party are labeled with media_app instead of untrusted_app
The applications installed from third party, which will be "untrusted_app" (e.g., cts test apks), do not have "seinfo==media".
Therefore, these applications will not be labeled as "media_app" (policy in seapp_contexts). But these applications will
call the same permissions of regular media_app. So, we need to add these untrusted_app to media_app class. 

Note that those application are for CTS test (currently we do not find others). So a better way should be proposing 
bool-enabled scheme in seapp_contexts, which has been discussed among us yesterday. We could update later 
if the new scheme is done. (Waiting for you guys' comments) 

[PATCH 2/3] external/sepolicy: install daemon link/unlink application data files
the installer daemon get the permissions (link, unlink) the application data files. 

[PATCH 3/3] external/sepolicy: system r/w udp_socket of untrusted apps
system get the read/write permissions on udp_socket related to untrusted applications. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
