Subject: Re: openssh 3.6 patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <se8aacb2.006@atlas.snu.edu>
References: <se8aacb2.006@atlas.snu.edu>
Content-Type: text/plain
Date: 08 Apr 2003 08:07:54 -0400
Message-Id: <1049803675.1588.1.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-02 at 10:25, Joshua Brindle wrote:
> openssh 3.6 is out, enclosed is a patch (based off cokers 3.5) which will add selinux functionality to it

Your patch seems to include several changes that have nothing to do with
SELinux, and that are not part of the upstream NSA SELinux patch to
openssh.  I assume that they are independent bug fix patches that have
been merged, but you might want to keep them separated.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
