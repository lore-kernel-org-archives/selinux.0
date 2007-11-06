Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6DfCs0014322
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 08:41:12 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lA6DfAsc005769
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 13:41:10 GMT
Subject: Re: permissions to create directories in the /tmp directory
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02554E7E@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02554E7E@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Tue, 06 Nov 2007 08:38:11 -0500
Message-Id: <1194356291.4047.4.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-11-05 at 14:33 -0800, Clarkson, Mike R (US SSA) wrote:
> Is there an interface that gives permissions to create directories in
> the /tmp dir (allow ... tmp_t:dir create)?
> 
> I couldn't find one. I found files_manage_generic_tmp_files in files.if,
> but this doesn't do it. It allows creating files but not directories of
> type tmp_t. I ended up adding an interface to files.if myself, but I
> figure that has to have come up already.

If its a confined process, this doesn't actually come up normally.
Since /tmp is shared all over the place, we usually add a type for the
domain's tmp file.  Then we use file_tmp_filetrans() so when the domain
creates files in /tmp, it gets the right type.  So this results in
something like this:

manage_dirs_pattern(sendmail_t, sendmail_tmp_t, sendmail_tmp_t)
manage_files_pattern(sendmail_t, sendmail_tmp_t, sendmail_tmp_t)
files_tmp_filetrans(sendmail_t, sendmail_tmp_t, { file dir })

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
