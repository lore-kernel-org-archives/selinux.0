From: "R N" <rnmj44@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: SELinux and SystemImager
Date: Fri, 13 Feb 2004 11:49:37 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F60HnYHraK2yR000043ec3@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

Has anyone tried creating multiple SELinux systems using SystemImager (or 
Symantec Ghost and like). We have been using SystemImager successfully to 
clone Linux based system for our cluster. SystemImager is based on rsync. 
Now I tried to clone a SELinux system, the initial steps of grabbing the 
golden-client image at the server are successful and I could create a new 
client using the same image from the server. But when I try to reboot the 
new client, it gives all kinds of avc_denied errors. and doesn't boot.

Our requirement is to be able to clone SeLinux systems. Any help in this 
regard would be appreciated.

Thanks,
-Rajeev

_________________________________________________________________
Choose now from 4 levels of MSN Hotmail Extra Storage - no more account 
overload! http://click.atdmt.com/AVE/go/onm00200362ave/direct/01/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
