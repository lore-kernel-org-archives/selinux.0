Message-ID: <4078835F.2030801@snu.edu>
Date: Sat, 10 Apr 2004 18:29:35 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: audio-entropyd policy
Content-Type: multipart/mixed;
 boundary="------------070507050404070400090708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070507050404070400090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

audio-entropyd available at http://www.vanheusden.com/aed/ adds entropy 
from sound devices (after being cleansed and hashed). This is 
particularly useful on headless servers which don't get any 
mouse/keyboard related entropy. The policy was written by Chris Pebenito.

Joshua Brindle

--------------070507050404070400090708
Content-Type: text/plain;
 name="audio-entropyd.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio-entropyd.te"

#DESC audio-entropyd - Generate entropy from audio input
#
# Author: Chris PeBenito <pebenito@gentoo.org>
#

daemon_domain(entropyd)

allow entropyd_t self:capability { ipc_lock sys_admin };

allow entropyd_t random_device_t:chr_file rw_file_perms;
allow entropyd_t device_t:dir r_dir_perms;
allow entropyd_t sound_device_t:chr_file r_file_perms;

--------------070507050404070400090708
Content-Type: text/plain;
 name="audio-entropyd.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio-entropyd.fc"

/usr/sbin/audio-entropyd	--	system_u:object_r:entropyd_exec_t

--------------070507050404070400090708--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
