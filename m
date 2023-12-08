Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rqmqt3cb"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C610DF
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702006598; x=1733542598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nw0vPx6RYP/2hVuvwI8VGpJutQ3fGf7bdNmbQU4PUFI=;
  b=Rqmqt3cbDUpOYtEpblxY6DHSKXyzUZH1eUUmyNVlT1cvEobOFaDzIr+p
   xzXVGFm7pnOA84qvqzy4zUevQoa66YkndAdBUPc7sRz0DUcek3I7XFwaB
   4GKFo+Zm4f03bWhpZ8gZ6t5KAyexLjoYkVPhq+Iwe6E+ySUVLsyM/MqA8
   4=;
X-IronPort-AV: E=Sophos;i="6.04,259,1695686400"; 
   d="scan'208";a="689112851"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:36:37 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id AF2DF80741;
	Fri,  8 Dec 2023 03:36:36 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:2823]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.170:2525] with esmtp (Farcaster)
 id e1b68bfb-8e21-4226-9c2d-d391e8e41437; Fri, 8 Dec 2023 03:36:36 +0000 (UTC)
X-Farcaster-Flow-ID: e1b68bfb-8e21-4226-9c2d-d391e8e41437
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Dec 2023 03:36:36 +0000
Received: from u0acfa43c8cad58.ant.amazon.com (10.106.101.36) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Dec 2023 03:36:34 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <paul@paul-moore.com>
CC: <kamatam@amazon.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v2] selinux: remove the wrong comment about multithreaded  process handling
Date: Thu, 7 Dec 2023 19:36:22 -0800
Message-ID: <20231208033622.1739868-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <41bdb9588162bc706786e2c341f01f07@paul-moore.com>
References: <41bdb9588162bc706786e2c341f01f07@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

On Thu, 2023-12-07 09:46:54 -0800, Paul Moore wrote:
>
> On Dec  6, 2023 Munehisa Kamata <kamatam@amazon.com> wrote:
> > 
> > Since commit d9250dea3f89 ("SELinux: add boundary support and thread
> > context assignment"), SELinux has been supporting assigning per-thread
> > security context under a constraint and the comment was updated
> > accordingly. However, seems like commit d84f4f992cbd ("CRED: Inaugurate
> > COW credentials") accidentally brought the old comment back that doesn't
> > match what the code does.
> > 
> > Considering the ease of understanding the code, this patch just removes the
> > wrong comment.
> > 
> > Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
> > Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> > ---
> > 
> > v1 -> v2: just remove the comment instead of bringing back the old one as suggested by Paul
> > 
> >  security/selinux/hooks.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Merged into selinux/dev, thanks!

Thank you, too :)

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 855589b64641..863ff67e7849 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6459,7 +6459,6 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
> >  		if (sid == 0)
> >  			goto abort_change;
> >  
> > -		/* Only allow single threaded processes to change context */
> >  		if (!current_is_single_threaded()) {
> >  			error = security_bounded_transition(tsec->sid, sid);
> >  			if (error)
> > -- 
> > 2.40.1
> 
> --
> paul-moore.com
> 
