Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kARMjGa9015338
	for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2006 17:45:16 -0500
Subject: Re: [PATCH 3/5] libselinux: security_class_to_string helper
	function
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <455E5C6C.5010405@kaigai.gr.jp>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
	 <1163714050.15225.134.camel@moss-huskies.epoch.ncsc.mil>
	 <455E5C6C.5010405@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 17:45:15 -0500
Message-Id: <1164667515.2794.91.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-11-18 at 10:05 +0900, KaiGai Kohei wrote:
> Eamon Walsh wrote:
> > A new helper function that converts from class value to class name.  
> 
> Do you have a plan to provide 'security_av_perm_to_string()' function?
> I like to use them to generate a message in the PostgreSQL extension.

OK, since there is a usage case I will add this function to patch 3 on
the next go-round.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
