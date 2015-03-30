Message-ID: <5519B1A8.4050503@tycho.nsa.gov>
Date: Mon, 30 Mar 2015 16:27:20 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Re: Interpreter name reported in AVC comm field
References: <91685a974f164d458eda1aa6d18c769b@MIVEXUSR1N02.corpzone.internalzone.com>
In-Reply-To: <91685a974f164d458eda1aa6d18c769b@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/30/2015 03:51 PM, Minear, Spencer wrote:
> I have the following problem with adding SE Linux control to and existing system that makes it hard to interpret the policy deny audits.  
> 
> My specific issue is a system that makes use of a significant number programs that are really just shell scripts or python scripts.  For example say that /bin/XYZ starts with '#!/usr/bin/python'.   The first action of starting the XYZ program is to exec /bin/XYZ.  If there is a policy violation at this point in time the AVC audit will show the comm as "XYZ".  Thus making it easy to figure out which program one should be looking at.  However shortly after the program is started the kernel sees the reference to the interpreter at the start of the file and then it goes off and exec's /usr/bin/python.  After that point if a policy problem occurs the AVC audit comm field now contains "python" .    Given that there can be lots of python programs running at one time, it makes it quit difficult to determine what program is triggering the problem.
> 
> I did run into the same problem in another system that I've worked on a lot over the years.  In that case we addressed the problem by making a simple change in the kernel exec processing so the policy audit would provide the initial command name, which we viewed as being the more useful information, not the "last exec'd" interpreter name.  I have not looked at the Linux kernel code to assess the issues or to see if it may or may not be amenable to this type of change.  
> 
> Figure I'd ask to see if it has ever been considered.  If I'm really lucky there maybe a flag that that can be turned on that would allow me to change the behavior or maybe there are reasons why it was never done, or was deemed a bad thing to do. 

Not sure if this helps, but recent kernels log an additional proctitle=
audit record with what you would see via cat /proc/pid/cmdline for the
process.  This assumes you have syscall audit enabled.

Example audit output for a single denial during selinux-testsuite:

type=PROCTITLE msg=audit(03/30/2015 16:07:20.249:976) : proctitle=dd
if=/dev/zero of=bounds/bounds_file_blue count=1

type=SYSCALL msg=audit(03/30/2015 16:07:20.249:976) : arch=x86_64
syscall=open success=no exit=-13(Permission denied) a0=0x7fffe490a052
a1=O_WRONLY|O_CREAT|O_TRUNC a2=0666 a3=0x0 items=0 ppid=13889 pid=13890
auid=sds uid=root gid=root euid=root suid=root fsuid=root egid=root
sgid=root fsgid=root tty=pts0 ses=1 comm=dd exe=/usr/bin/dd
subj=unconfined_u:unconfined_r:test_bounds_child_t:s0-s0:c0.c1023
key=(null)

type=AVC msg=audit(03/30/2015 16:07:20.249:976) : avc:  denied  { write
} for  pid=13890 comm=dd name=bounds_file_blue dev="dm-2" ino=14555307
scontext=unconfined_u:unconfined_r:test_bounds_child_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:test_bounds_file_blue_t:s0 tclass=file
permissive=0

This is with auditd running and using ausearch -i to decode the fields.
