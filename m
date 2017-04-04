Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v342qD6w018672
 for <selinux@tycho.nsa.gov>; Mon, 3 Apr 2017 22:52:13 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: Running Java and JVM on SELinux
Date: Tue, 4 Apr 2017 12:52:05 +1000
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdpRxYsMHyDKmRtCswovHRgda1nW2ELUVVKPVtBrL9HL8Q@mail.gmail.com>
 <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
In-Reply-To: <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201704041252.05196.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 4 Apr 2017 12:35:47 PM Rahmadi Trimananda wrote:
> I have more error messages from /var/log/audit/audit.log if this is of any
> use for you. And yeah, it works in permissive mode (sudo setenforce 0).
> BTW, what do you mean by "run javac in strace"?
> 
> iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log | grep
> javac
> type=AVC msg=audit(1491260813.624:793): avc:  denied  { mmap_zero } for
>  pid=1656 comm="javac"
> scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0

Try permitting that one and see if it changes things.  What version of javac 
are you using?  Is it an old version?

Also when posting such things to the list please include the output of 
auditallow as well as the raw AVC messages whenever you send more than 2-3 
entries.  When your MUA wraps the lines the result isn't accepted by 
audit2allow and that makes it less convenient for us to process your messages 
(usually audit2allow output is more useful than reading raw AVC log entries).

If there is only a single AVC message then we can all run audit2allow in our 
heads.  ;)

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
