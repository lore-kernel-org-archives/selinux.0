Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4V9V7wB007171
	for <selinux@tycho.nsa.gov>; Wed, 31 May 2006 05:31:07 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4V9V5oA011276
	for <selinux@tycho.nsa.gov>; Wed, 31 May 2006 09:31:06 GMT
Received: by ug-out-1314.google.com with SMTP id y2so901069uge
        for <selinux@tycho.nsa.gov>; Wed, 31 May 2006 02:31:05 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: Trouble with /lib/libselinux and linking
Date: Wed, 31 May 2006 11:30:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <447d6259.4bf9ee2d.48c3.ffff96ac@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have written a simple program that uses SELinux API but when I try to
compile it, gcc gives me an error says that it's unable to resolve reference
to getcon() function.
The program is like:

#include <selinux/selinux.h>
#include <stdio.h>

int main(int argc,char *argv[]){
	security_context_t scontext;
	if(getcon(&scontext))....
}

The only way is to link statically the library and thus if I use "gcc
-lselinux program.c" all works...
Moreover if I use nm on libselinux.so, I don't receive any output..Isn't it
unusual?  
Anyone can give me a explanation?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
