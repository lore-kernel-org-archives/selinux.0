Message-Id: <200503172228.AA00008@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Fri, 18 Mar 2005 07:28:58 +0900
To: SELinux@tycho.nsa.gov
Subject: Do you trust X server?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hello.

I am not sure that here is the proper place to discuss this issue,
but do you trust X server (or video driver), when you use your PC
with X window?.

Most ( and probably all) X server runs as root on Linux.
Then, if it has ( and it must have ) a buffer overflow or any vulnerability,
and it would execute some cruel code if a certain drawing commands set comes.
A cracker makes web sites contain htmls or SVG or ... to make a such commands
set to be displayed. Then, you can be cracked with just browsing the pages,
not being required to click untrusted contents explicitly.

Have you considered this risk? Is there any site about this issue?
And any measure to solve this issue with SE linux?

                 --- Okajima, Jun. Tokyo, Japan.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
