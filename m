Subject: Re: [PATCH] restorecon manpage: link back to fixfiles
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
 <20170111124110.5721-2-alan.christopher.jenkins@gmail.com>
 <1484251293.16361.3.camel@tycho.nsa.gov>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <8194a97b-705d-d147-854a-32f95187bc6d@gmail.com>
Date: Thu, 12 Jan 2017 20:47:47 +0000
MIME-Version: 1.0
In-Reply-To: <1484251293.16361.3.camel@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="------------ACC3A9784F61953560884CB3"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------ACC3A9784F61953560884CB3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/01/17 20:01, Stephen Smalley wrote:
> On Wed, 2017-01-11 at 12:41 +0000, Alan Jenkins wrote:
>> fixfiles links to restorecon.  However if you start with restorecon
>> "restore file(s) default SELinux security contexts", you can easily
>> miss the fixfiles script.  fixfiles is more generally useful than
>> `restorecon -R`.   For example `restorecon -R /` is not as good as
>> `fixfiles restore`, because the restorecon command will try to
>> relabel
>> `/sys` and fail noisily.
> Thanks, applied both patches.
yay!

>    Wondering though about the behavior
> you describe above; restorecon -R /sys only issues one error message
> for me and otherwise works fine,
> # restorecon -R /sys
> Could not set context for /sys/fs/cgroup:  Read-only file system

It turned out fixfiles also generated similar noise.  I suspect this 
involved `-v` (in both cases), sorry.

Fedora Workstation 25:
"fixfiles spams warnings about debugfs. (docs say it only touches "real" 
filesystems!)" https://bugzilla.redhat.com/show_bug.cgi?id=1412747

Perhaps the root cause is actually the same.  I still prefer the 
messages from fixfiles though.  It explicitly detected conflicting 
labels on hardlinks

https://bugzilla.redhat.com/show_bug.cgi?id=1411371

and informed me in advance when it decided to traverse and relabel five 
of my virtual filesystems

    Checking / /boot /dev /dev/hugepages /dev/mqueue /dev/pts /dev/shm
    /home /run /run/user/1000 /run/user/1001 /run/user/42 /sys
    /sys/fs/pstore /sys/kernel/debug /tmp

(I doubt devtmpfs files are _intended_ to be labeled like this either.  
OTOH the stupidity doesn't seem to affect it, so I won't complain there).

--------------ACC3A9784F61953560884CB3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 12/01/17 20:01, Stephen Smalley wrote:<br>
    <blockquote cite="mid:1484251293.16361.3.camel@tycho.nsa.gov"
      type="cite">
      <pre wrap="">On Wed, 2017-01-11 at 12:41 +0000, Alan Jenkins wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">fixfiles links to restorecon.  However if you start with restorecon
"restore file(s) default SELinux security contexts", you can easily
miss the fixfiles script.  fixfiles is more generally useful than
`restorecon -R`.   For example `restorecon -R /` is not as good as
`fixfiles restore`, because the restorecon command will try to
relabel
`/sys` and fail noisily.
</pre>
      </blockquote>
      <pre wrap="">
Thanks, applied both patches.</pre>
    </blockquote>
    yay!<br>
    <br>
    <blockquote cite="mid:1484251293.16361.3.camel@tycho.nsa.gov"
      type="cite">
      <pre wrap="">  Wondering though about the behavior
you describe above; restorecon -R /sys only issues one error message
for me and otherwise works fine,
# restorecon -R /sys
Could not set context for /sys/fs/cgroup:  Read-only file system
</pre>
    </blockquote>
    <br>
    It turned out fixfiles also generated similar noise.  I suspect this
    involved `-v` (in both cases), sorry.<br>
    <br>
    Fedora Workstation 25:<br>
    "fixfiles spams warnings about debugfs. (docs say it only touches
    "real" filesystems!)"
    <a class="moz-txt-link-freetext" href="https://bugzilla.redhat.com/show_bug.cgi?id=1412747">https://bugzilla.redhat.com/show_bug.cgi?id=1412747</a><br>
    <br>
    Perhaps the root cause is actually the same.  I still prefer the
    messages from fixfiles though.  It explicitly detected conflicting
    labels on hardlinks<br>
    <br>
    <a class="moz-txt-link-freetext"
      href="https://bugzilla.redhat.com/show_bug.cgi?id=1411371">https://bugzilla.redhat.com/show_bug.cgi?id=1411371</a><br>
    <br>
    and informed me in advance when it decided to traverse and relabel
    five of my virtual filesystems<br>
    <blockquote>Checking / /boot /dev /dev/hugepages /dev/mqueue
      /dev/pts /dev/shm /home /run /run/user/1000 /run/user/1001
      /run/user/42 /sys /sys/fs/pstore /sys/kernel/debug /tmp<br>
    </blockquote>
    (I doubt devtmpfs files are _intended_ to be labeled like this
    either.  OTOH the stupidity doesn't seem to affect it, so I won't
    complain there).<br>
  </body>
</html>

--------------ACC3A9784F61953560884CB3--
