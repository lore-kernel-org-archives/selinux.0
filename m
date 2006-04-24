Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3OKs7i1003748
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 16:54:07 -0400
Received: from mx52.ms.so-net.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3OKs5QT010806
	for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2006 20:54:06 GMT
Date: Tue, 25 Apr 2006 06:04:53 +0900
From: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
To: method@gentoo.org
Cc: selinux@tycho.nsa.gov
Subject: Re: semodule fails(I found it !)
Message-Id: <20060425060453.05c76a27.shin216@xf7.so-net.ne.jp>
In-Reply-To: <20060425054007.5d481154.shin216@xf7.so-net.ne.jp>
References: <20060425000740.41ed51f5.shin216@xf7.so-net.ne.jp>
	<444CEAF7.20503@gentoo.org>
	<20060425054007.5d481154.shin216@xf7.so-net.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Oh, I found another .te file which described
allow staff_t stuff...
which I have written some days ago.
I named it by_me.pp and it is loaded.
I found by semodule -l.

Now,I can't semodule -r by_me.pp,so
I had better clear strict policy altogether,
and do it again...

Thank you for let me know the point.


On Tue, 25 Apr 2006 05:40:07 +0900
Shintaro Fujiwara <shin216@xf7.so-net.ne.jp> wrote:

> 
> Thank you for your advice.
> 
> > What is in postgresql_by_me.te? I suspect this isn't a toolchain failure 
> > but actually real assertion failures due to just dumping rules from 
> > audit2allow into a te file.
> 
> I used policygentool to make policy,so I don't think it is assertion failure.
> But I can comment out these and make again...
> 
> Here's what postgresql_by_me_t has.
> *********
> type postgresql_by_me_t;
> type postgresql_by_me_exec_t;
> domain_type(postgresql_by_me_t)
> init_daemon_domain(postgresql_by_me_t, postgresql_by_me_exec_t)
> ********
> files_read_etc_files(postgresql_by_me_t)
> libs_use_ld_so(postgresql_by_me_t)
> libs_use_shared_libs(postgresql_by_me_t)
> miscfiles_read_localization(postgresql_by_me_t)
> allow postgresql_by_me_t self:fifo_file { read write };
> allow postgresql_by_me_t self:unix_stream_socket create_stream_socket_perms;
> *********
> 
> I commented out all these macro lines,but failed again...
> Thanks.
> 
> On Mon, 24 Apr 2006 11:12:55 -0400
> Joshua Brindle <method@gentoo.org> wrote:
> 
> > Shintaro Fujiwara wrote:
> > > Hi,
> > >
> > > When I try to install .pp file, it fails with messages.
> > >
> > > #semodule -i postgresql_by_me.pp
> > > libsepol.check_assertion_helper: assertion on line 0 violated by allow staff_t memory_device_t:chr_file { write };
> > > libsepol.check_assertion_helper: assertion on line 0 violated by allow staff_t memory_device_t:chr_file { read };
> > > libsepol.check_assertions: 2 assertion violations occured
> > > libsemanage.semanage_expand_sandbox: Expand module failed
> > > semodule: Failed!
> > >
> > > I saw archives and it says that libsepol-1.11 could solve the problem,
> > > but mine is 1.12.
> > >
> > >   
> > What is in postgresql_by_me.te? I suspect this isn't a toolchain failure 
> > but actually real assertion failures due to just dumping rules from 
> > audit2allow into a te file.
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
