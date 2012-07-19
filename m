From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com
Subject: updates from Haiqing Jiang on Jul. 19
Date: Thu, 19 Jul 2012 16:07:50 -0700
Message-Id: <1342739276-1686-1-git-send-email-hqjiang1988@gmail.com>
In-Reply-To: <Hi, all>
References: <Hi, all>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have several updates here, waiting for your insightful comments.

1: [PATCH 1/6] external/sepolicy: allow media_app more permissions on sdcard
currently media_app has merely create_file_perms. We add link_file_perms.
2: [PATCH 2/6] external/sepolicy: mediaserver open application data files
mediaserver has the open permissions over app_data_file.
3: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via socket
mediaserver talk to radio level daemon via udp_stream_socket.
4: [PATCH 4/6] external/sepolicy: system talk to rild via socket
talk to rild via socket.
5: [PATCH 5/6] external/sepolicy: allow media_app read to application data files
allow media_app r_file_perms over app_data_file.
6: [PATCH 6/6] external/sepolicy: android_cts test denials
We got several denials from CTS test. We add corresponding policies in cts.te. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
