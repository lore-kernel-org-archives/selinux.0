Message-ID: <20160926083811.30682dgg5kr92vr4@webmail.alunos.dcc.fc.up.pt>
Date: Mon, 26 Sep 2016 08:38:11 +0200
From: up201407890@alunos.dcc.fc.up.pt
To: "Paul Eggert" <eggert@cs.ucla.edu>
Cc: 24541@debbugs.gnu.org, SE-Linux <SELinux@tycho.nsa.gov>
Subject: Re: bug#24541: runcon tty hijacking via TIOCSTI ioctl
References: <20160925133955.72163x0kftak7yqs@webmail.alunos.dcc.fc.up.pt>
 <ad807471-3549-b9fa-e718-8110e6a768b2@cs.ucla.edu>
In-Reply-To: <ad807471-3549-b9fa-e718-8110e6a768b2@cs.ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting "Paul Eggert" <eggert@cs.ucla.edu>:

Hello,

I set the bug report here before I got a response from Paul Moore
https://marc.info/?l=selinux&m=147481004710264&w=2

"I don't think we need to fix this for runcon, as it isn't as
sandboxing tool like sandbox, and the loss of job control would likely
be much more noticeable for runcon."


> up201407890@alunos.dcc.fc.up.pt wrote re <http://bugs.gnu.org/24541>:
>> When executing a program via the runcon utility, the nonpriv session
>> can escape to the parent session by using the TIOCSTI ioctl to push
>> characters into the terminal's input buffer, allowing an attacker to
>> execute arbitrary commands without the SELinux security context.
>
> Thanks for the bug report. Surely this is a bug in the setexeccon  
> system call, not in the runcon command that uses the system call.  
> That being said, perhaps runcon should work around the bug via  
> something like the attached patch.
>



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
