Date: Mon, 18 Nov 2002 14:34:43 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Mark Westerman <mark.westerman@westcam.com>, SELinux@tycho.nsa.gov
Subject: Re: XML based file structure for SE-Linux
Message-ID: <20021118033443.GC19293@snoopy.apana.org.au>
References: <862636C39A8D56448223B94D19757133015E91@server.westcam.com> <200211151416.15981.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
In-Reply-To: <200211151416.15981.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2002 at 02:16:15PM +0100, Russell Coker wrote:
> > We have even
> > started to convert the rules to XML so update to policies can be handled
> > more programmatically. The initial XML version uses XLST template to create
> > the policy.conf file and uses the checkpolicy to compile the policy.conf
> > file. The XML stuff is not near ready for public consumption.
> 
> Brian May has started work on similar things.  What you have developed may not 
> be ready for public consumption, but it may be ready to be sent to Brian.  
> I'm sure that Brian could offer some useful suggestions for it.

Yes, I had developed my own XML format, and wrote a program that would
read it and output a M4 file, similar to the current format (this is
probably could be considered a limitation; the current format was never
designed to cope with structured data like this). Still to come, a DTD
to validate the XML structure.

The more I use XSLT, the more I grow to dislike it, so I haven't used it
for my format, but I don't discourage other people to use it
themselves... In general I find XSLT not to support some really simple
operations I need easierly, and painfully slow when doing these simple
operations using some of the complicated work-arounds that are
available. It is possible at least some of the problems I have had might
improve in the next version of the XSLT standard.

One of the aims of the XML format is that I eliminate the need to use
"ifdef(package,...)", which IMHO reduce scalability of the format. My
idea is that adding a new package should only require adding that
package file, and allow certain users access to it. I am not sure
certain this is feasible; the problem being when package X can
optionally use package Y... I might need to somehow add support for
optional depends later on.

Another aim was to remove any need for user defined macros. (in practise
this means any programs that parses the XML files will need to be
easierly extended to support future enhancements, something I haven't
yet done).

In my XML file, I give SE-Linux policy a structure, based around
a "class".

A class is like a class in C++, but when you create an instance of a
class you end up with a stanard SE-Linux domain.

Classes can inherit from other classes, so for instance in my very
simple test case, "user_c" and "sysadm_c" both are derived from the
"anyuser_c" class. So any operation that a domain of class "anyuser_c"
can do, can also be performed by domains of class "user_c" and
"sysadm_c".o

Similarly, every class can have a set of nested classes, so for
instance, the "user_c" class can contain the "mount class", so whenever
a "user_c" domain runs /sbin/mount, it will actually run it in the
"user_c/mount_c" domain, which would be implemented as a seperate domain
to the "sysasdm_c/mount_c" domain.

Obviously, I also also allow global domains to be formed from classes,
and allow some extra information (eg. description, justification, when
to remove) to be associated with each rule).

The only other perhaps unclear rule is the "nested_domain_auto_trans"
thing. Normally the "domain_auto_trans" are for transferring *this*
domain to *another* domain. However, that meant information had to be
duplicated. I concluded it was better to have a system for transfering
*another* domain to *this* domain, which is essientially what
"nested_domain_auto_trans" does.

Everything else should (hopefully) be pretty much obvious, as I have
attempted to do a 1:1 mapping with the current M4 format.

It has been a while since I looked at it last, but currently I am still
pretty happy with the design. Some simple changes could be done though
to bring it up to Russell's latest policy, for instance a "chroot"
element, and dependancy/conflict information would be easy to add.

What I have:

- Simple XML files (attached). I have attempted to choose a more
  complicated situation (eg. mount) in order to prove that the XML
  format can cope with it.

- Ada program that will read these XML files and output a (hopefully
  valid) SE-Linux M4 file. (requires gnat, both obsolete and mostly
  bug-free version and new gcc 3.1,3.2 version seem to work fine, and
  xmlada-0.7.1).

What is still required:
- DTD to validate XML structure.

- Program to read XML file and ensure all cross references are valid.

- Write a complete policy using this XML format.

- Document XML file structure.

Further work:

- attributes cause a number of big problems, and I could not work out
  how to support them cleanly, mainly because I couldn't work out how to
  implement the M4 so a class will inherit the attributes of its
  ancestors in a clean manner (AFAIK it is not possible to add
  attributes to an existing domain, all attributes have to be declared
  when the domain is delared). In a future version I would like to get
  rid of attributes and just rely on class inherentence instead. I am
  under the impression this will do just as well.

- Consider adding extra information to help upgrading policy, for
  instance added-by="bam". The upgrader could somehow use this
  information and automatically upgrade certain parts of the policy
  based on a given and locally set criteria. (eg. if replacement rule
  digitally signed by bam and has urgency=high and replaces an
  existing rule which is also signed by bam, replace it immediatly
  without asking).

- Mapping of structured XML names to unstructured M4 names (not
  attached) is absolutely horrible, mostly because there is only one
  "seperation" character that I could use, which is already frequently
  used (_). This can't be changed though without changing both SE-Linux
  and M4. A better approach in the future might be to skip the
  intermediate M4 format altogether and go straight to the binary
  policy format.

Any comments?

Does this make any sense what-so-ever?

(disclaimer: this XML structure is subject to change...)
--
Brian May <bam@snoopy.apana.org.au>

--gKMricLos+KVdGMg
Content-Type: text/xml; charset=us-ascii
Content-Disposition: attachment; filename="mount.xml"

<package id="mount" version="2.11n-4">
  <info>
    <description>Mount program.</description>
  </info>

  <global>
    <type id="mount_exec">
      <info>
        <description>Mount Executable</description>
      </info>
      <attributes>
        <attribute ref="/file_type_t"/>
        <attribute ref="/exec_file_t"/>
        <attribute ref="/sysadmfile_t"/>
      </attributes>
    </type>
  </global>

  <class id="mount">
    <info>
      <description>Domain for mount program.</description>
    </info>
    <attributes>
      <attribute ref="/domain"/>
      <attribute ref="/privlog"/>
    </attributes>
    <type id="mount_tmp">
      <info>
        <description>Tmp file in mount domain</description>
        <justification>Mount needs to create temp files in /tmp.</justification>
	<remove>If mount no longer creates temp files.</remove>
      </info>
      <attributes>
        <attribute ref="/file_type_t"/>
        <attribute ref="/sysadmfile_t"/>
        <attribute ref="/tmpfile_t"/>
      </attributes>
    </type>
    <nested_domain_auto_trans id="default">
      <info>
        <description>Allow user to run mount.</description>
      </info>
      <filetype ref="/mount/mount_exec"/>
    </nested_domain_auto_trans>
    <file_type_auto_trans>
      <info>
        <description>Any file created under tmp dir gets mount_tmp domain.</description>
        <justification>Mount needs to create temp files in /tmp.</justification>
	<remove>If mount no longer creates temp files.</remove>
      </info>
      <scontext ref="self"/>
      <filetype ref="/tmp"/>
      <toclass ref="mount_tmp"/>
    </file_type_auto_trans>
    <allow>
      <info>
        <description>Allow class to use capabilities.</description>
        <justification>Mount needs to use certain capabilities</justification>
      </info>
      <scontext ref="self"/>
      <tcontext ref="self"/>
      <capability>
	<sys_sysadm/>
	<sys_rawio/>
	<dac_override/>
	<net_bind_service/>
      </capability>
    </allow>
    <file_type_auto_trans>
      <info>
        <description>Create and modify /etc/mtab.</description>
        <justification>/etc/mtab lists current mounts.</justification>
	<remove>Remove if /etc/mtab gets replaced with a symlink.</remove>
      </info>
      <scontext ref="self"/>
      <filetype ref="/etc"/>
      <toclass ref="/etc_runtime"/>
    </file_type_auto_trans>
  </class>
</package>

--gKMricLos+KVdGMg
Content-Type: text/xml; charset=us-ascii
Content-Disposition: attachment; filename="users.xml"

<package id="users" version="0.1">
  <info>
    <description>Users of the computer.</description>
  </info>

  <class id="anyuser_c">
    <info>
      <description>User class.</description>
    </info>
    <attributes>
      <attribute ref="/domain"/>
      <attribute ref="/userdomain"/>
      <attribute ref="/unpriv_userdomain"/>
    </attributes>

    <type id="tty_device">
    <info>
      <description>TTY Device</description>
    </info>
    <attributes>
      <attribute ref="/file_type_t"/>
      <attribute ref="/sysadmfile_t"/>
      <attribute ref="/ttyfile"/>
    </attributes>
    </type>
  </class>

  <class id="tty_c">
    <info>
      <description>User TTY class.</description>
    </info>
    <allow>
      <scontext ref="self"/>
      <tcontext ref="tty_device"/>
      <tcontext ref="devpts"/>
      <chr_file>
	<rw_file_perms/>
      </chr_file>
    </allow>
  </class>

  <class id="mount_c">
    <info>
      <description>User Mount class.</description>
    </info>
    <parent ref="tty"/>
    <parent ref="/mount/mount"/>
  </class>

  <class id="user_c">
    <info>
      <description>User class.</description>
    </info>
    <attributes>
      <attribute ref="/domain"/>
      <attribute ref="/userdomain"/>
    </attributes>
    <parent ref="anyuser"/>

    <nested id="mount" ref="mount" transition="default"/>
  </class>

  <class id="sysadm">
    <info>
      <description>Sysadm domain.</description>
    </info>
    <parent ref="../anyuser"/>
    <attributes>
      <attribute ref="/domain"/>
      <attribute ref="/userdomain"/>
    </attributes>

    <nested id="mount" ref="mount" transition="default"/>
  </class>

  <global>
      <info>
        <description>Users of computer.</description>
      </info>

    <domain id="user" ref="user_c"/>
    <domain id="sysadm" ref="sysadm_c"/>
  </global>
</package>

--gKMricLos+KVdGMg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
