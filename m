Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8L8wZWp009290
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 04:58:35 -0400
References: <CAFPpqQG3_aUEJW8fbz8sRtTPRcw2KUsQ+wtr3+-awjcws+PD0w@mail.gmail.com>
From: Petr Lautrbach <plautrba@redhat.com>
To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-reply-to: <CAFPpqQG3_aUEJW8fbz8sRtTPRcw2KUsQ+wtr3+-awjcws+PD0w@mail.gmail.com>
Date: Fri, 21 Sep 2018 10:58:27 +0200
Message-ID: <pjdfty3447g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: Re: file context not being set on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


Ted Toth <txtoth@gmail.com> writes:

> I have something very much like the following in an fc file:
> /usr/lib64/python2\.(6|7)/site-packages/xyz/paste     --
> gen_context(system_u:object_r:jxyz_exec_t,s0)
>
> and I use the same file on el6 and el7. On el6 the file is 
> labeled as
> specified in the python2.6 directory. However on el7 where the 
> file gets
> installed into python2.7 the file is not labeled correctly. On 
> el7
> `semanage fcontext -l | grep xyz` shows the file context 
> expected but
> `matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste` does 
> not return
> the expected context and `restorecon -RFv
> /usr/lib64/python2.7/site-packages/xyz` has no affect. The type 
> xyz_exec_t
> exists on both systems. It's probably something stupid I'm doing 
> but I'm
> just not seeing it. Has anyone else experienced similar issues?
>

There's equivalency rule /usr/lib64 -> /usr/lib on el7:

# semanage fcontext -a -t tmp_t 
  '/usr/lib64/python2\.(6|7)/site-packages/xyz/paste'                          
ValueError: File spec 
/usr/lib64/python2\.(6|7)/site-packages/xyz/paste conflicts with 
equivalency rule '/usr/lib64 /usr/lib'; Try adding 
'/usr/lib/python2\.(6|7)/site-packages/xyz/paste' instead


# semanage fcontext -a -t tmp_t 
  '/usr/lib/python2\.(6|7)/site-packages/xyz/paste' 

# matchpathcon /usr/lib64/python2.7/site-packages/xyz/paste
/usr/lib64/python2.7/site-packages/xyz/paste 
system_u:object_r:tmp_t:s0


Petr
