Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v346sg5p017701
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 02:54:42 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: Running Java and JVM on SELinux
Date: Tue, 4 Apr 2017 16:54:35 +1000
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAHFUiBOWL7mB3v13DuSEthz1-CyCLa+UO5zbUemy6riZpYRn+g@mail.gmail.com>
 <CAHFUiBNOnnCXHLBaA1Fyap_W1C2PFS2vNpJA_m_6uArMi7DDFA@mail.gmail.com>
In-Reply-To: <CAHFUiBNOnnCXHLBaA1Fyap_W1C2PFS2vNpJA_m_6uArMi7DDFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201704041654.35909.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 4 Apr 2017 04:37:59 PM Rahmadi Trimananda wrote:
> It seems that I need execmem and execstack as well? Here's the output from
> audit2allow:
> 
> require {
>         type unconfined_t;
>         class process { execstack execmem };
>         class memprotect mmap_zero;
> }
> 
> #============= unconfined_t ==============
> 
> #!!!! This avc is allowed in the current policy
> allow unconfined_t self:memprotect mmap_zero;

The "-l" option to audit2allow stops it generating duplicate rules.

> #!!!! This avc can be allowed using the boolean 'allow_execstack'
> allow unconfined_t self:process { execstack execmem };
> libs_legacy_use_shared_libs(unconfined_t)

Run "setsebool -P allow_execstack 1" to allow this.  But maybe try a different 
java system like openjdk.

> On Mon, Apr 3, 2017 at 11:32 PM, Rahmadi Trimananda <rtrimana@uci.edu>
> 
> wrote:
> > Alright, I am getting a different error this time after giving permission
> > to mmap_zero. This is after running java or javac in enforcing mode.
> > 
> > Java HotSpot(TM) Client VM warning: INFO: os::commit_memory(0x740ab000,
> > 163840, 1) failed; error='Permission denied' (errno=13)
> > #
> > # There is insufficient memory for the Java Runtime Environment to
> > continue.
> > # Native memory allocation (mmap) failed to map 163840 bytes for
> > committing reserved memory.
> > # An error report file with more information is saved as:
> > # /home/iotuser/policy/debug/hs_err_pid2878.log
> > 
> > On Mon, Apr 3, 2017 at 10:43 PM, Russell Coker <russell@coker.com.au>
> > 
> > wrote:
> >> On Tue, 4 Apr 2017 02:34:14 PM Rahmadi Trimananda wrote:
> >> > Umm, how's the easiest way to permit that one? Do I need to create a
> >> 
> >> local
> >> 
> >> > policy or can I just use a command line? Sorry I am really a newbie.
> >> > :)
> >> 
> >> Run "audit2allow -l -R < /var/log/audit/audit.log > local.te", that will
> >> generate the policy.
> >> 
> >> policy_module(local,0.0.0)
> >> 
> >> Edit local.te to remove allow lines that you don't want and also add the
> >> above
> >> as the first line.
> >> 
> >> Create a symlink from the example Makefile (which is
> >> /usr/share/doc/selinux-
> >> policy-dev/examples/Makefile on Debian if you have the
> >> selinux-policy-dev package installed) to the current directory.  Then
> >> run "make load" and your
> >> policy will be compiled and loaded.
> >> 
> >> > I am using javac 1.8.0_65. It is the same version for the "java"
> >> 
> >> program.
> >> 
> >> > java version "1.8.0_65"
> >> > Java(TM) SE Runtime Environment (build 1.8.0_65-b17)
> >> > Java HotSpot(TM) Client VM (build 25.65-b01, mixed mode)
> >> 
> >> I'm using openjdk which doesn't appear to require such access.
> >> 
> >> $ java -version
> >> openjdk version "1.8.0_121"
> >> OpenJDK Runtime Environment (build 1.8.0_121-8u121-b13-4-b13)
> >> OpenJDK 64-Bit Server VM (build 25.121-b13, mixed mode)
> >> 
> >> > On Mon, Apr 3, 2017 at 7:52 PM, Russell Coker <russell@coker.com.au>
> >> 
> >> wrote:
> >> > > On Tue, 4 Apr 2017 12:35:47 PM Rahmadi Trimananda wrote:
> >> > > > I have more error messages from /var/log/audit/audit.log if this
> >> > > > is
> >> 
> >> of
> >> 
> >> > > any
> >> > > 
> >> > > > use for you. And yeah, it works in permissive mode (sudo
> >> > > > setenforce
> >> 
> >> 0).
> >> 
> >> > > > BTW, what do you mean by "run javac in strace"?
> >> > > > 
> >> > > > iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log |
> >> 
> >> grep
> >> 
> >> > > > javac
> >> > > > type=AVC msg=audit(1491260813.624:793): avc:  denied  { mmap_zero
> >> > > > }
> >> 
> >> for
> >> 
> >> > > >  pid=1656 comm="javac"
> >> > > > 
> >> > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >> > > > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >> > > > tclass=memprotect permissive=0
> >> > > 
> >> > > Try permitting that one and see if it changes things.  What version
> >> > > of javac
> >> > > are you using?  Is it an old version?
> >> > > 
> >> > > Also when posting such things to the list please include the output
> >> > > of auditallow as well as the raw AVC messages whenever you send
> >> > > more than 2-3 entries.  When your MUA wraps the lines the result
> >> > > isn't accepted
> >> 
> >> by
> >> 
> >> > > audit2allow and that makes it less convenient for us to process your
> >> > > messages
> >> > > (usually audit2allow output is more useful than reading raw AVC log
> >> > > entries).
> >> > > 
> >> > > If there is only a single AVC message then we can all run
> >> > > audit2allow
> >> 
> >> in
> >> 
> >> > > our
> >> > > heads.  ;)
> >> > > 
> >> > > --
> >> > > My Main Blog         http://etbe.coker.com.au/
> >> > > My Documents Blog    http://doc.coker.com.au/
> >> 
> >> --
> >> My Main Blog         http://etbe.coker.com.au/
> >> My Documents Blog    http://doc.coker.com.au/
> > 
> > --
> > Kind regards,
> > Rahmadi Trimananda
> > 
> > Ph.D. student @ University of California, Irvine
> > "Stay hungry, stay foolish!" - Steve Jobs -

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
