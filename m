Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9GJkxrT013709
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 15:46:59 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9GJjki9017568
	for <selinux@tycho.nsa.gov>; Sat, 16 Oct 2004 19:45:46 GMT
Date: Sat, 16 Oct 2004 20:57:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>,
   RH SELinux list <rhselinux-list@redhat.com>
Subject: Re: mv and cp behavior.
Message-ID: <20041016195753.GD19398@lkcl.net>
References: <41712EEF.9090402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41712EEF.9090402@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Oct 16, 2004 at 10:23:43AM -0400, Daniel J Walsh wrote:

> I believe that the what mv/cp is doing is wrong and we could do better, 
> by default.
 
 after (funnily enough) just examining apache_macros.te, i don't see a
 file_auto_trans in there which i would have expected there to be.

 sure, there's a create_dir_file, but i would have expected at least to
 see some use of file_type_auto_trans($1_t, httpd_$1_content_t, httpd_$1_content_t)
 [i think that's right: if a user creates stuff in the
 httpd_user_content_t directory, it's given that same context]

 and yes i'd expect mv and cp to obey that file_type_auto_trans.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
