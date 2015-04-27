Message-ID: <553E53E2.2060206@cs.ucla.edu>
Date: Mon, 27 Apr 2015 08:21:06 -0700
From: Paul Eggert <eggert@cs.ucla.edu>
MIME-Version: 1.0
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>, 20437@debbugs.gnu.org
Subject: Re: bug#20437: ls links too many dynamic libraries
References: <553DC968.80809@cs.ucla.edu> <553E35B7.3020105@draigBrady.com>
 <553E417B.3040406@draigBrady.com>
In-Reply-To: <553E417B.3040406@draigBrady.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: SE-Linux <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Pádraig Brady wrote:
> Further reductions in deps
> might be possible by splitting up libselinux, allowing apps like ls
> that just read contexts, to link with the appropriate lib.

I tried to see how to send a copy of this bug <http://bugs.gnu.org/20437> to the 
libselinux developers, but the libselinux source distribution doesn't mention 
any way to file bug reports (!).  (So now I guess I have *two* bug reports to 
send them. :-)  Who maintains libselinux and how does one file and track a bug 
report about libselinux?
