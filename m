Date: Wed, 20 Nov 2002 11:16:42 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: azeredo@qmc.ufsc.br, SELinux@tycho.nsa.gov
Subject: Re: Still problems with RedHat8.0
Message-ID: <20021120001641.GF28431@snoopy.apana.org.au>
References: <1037722529.3dda63a114991@qmc.ufsc.br> <200211200033.35017.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211200033.35017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 20, 2002 at 12:33:35AM +0100, Russell Coker wrote:
> > avc:  denied  { read } for  pid=751 exe=/usr/bin/magicdev path=/dev/hdd
> > dev=03:05 ino=33539 scontext=root:sysadm_r:sysadm_t
> > tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file
> 
> What is magicdev?

According to <URL:http://www.ccs.neu.edu/home/bchafy/magicdev.html>, it
is "an automount/autoplay package for CD's and floppy's under linux
redhat 6.1".

> > avc:  denied  { execute } for  pid=755 exe=/usr/bin/gnome-session
> > path=/usr/share/rhn/rhn_applet/applet.py dev=03:05 ino=833120
> > scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:usr_t
> > tclass=file
> 
> What is rhn?

A gnome panel applet somehow related to the "Red Hat Network" ????

Just guessing here, I also saw rhn here:
<URL:http://rhn.redhat.com/>.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
