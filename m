Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v29AKmTM028561
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 05:20:48 -0500
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: Custom Process Label (SElinux)
Date: Thu, 9 Mar 2017 21:20:40 +1100
Cc: Kashif ali <kashif.ali.9498@gmail.com>, Daniel J Walsh <dwalsh@redhat.com>,
 Sebastiaan van Stijn <sebastiaan.vanstijn@docker.com>
References: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
In-Reply-To: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201703092120.40209.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 9 Mar 2017 08:42:26 PM Kashif ali wrote:
>   i have created a module for my custom service with seplogen command it
> has generated the policy module for my custom service and context for its
> /usr/bin/mycustomeservicedaemon which is custom_service_exec_t when i run
> my service it doesn't get the label of  custom_service_t where as it has
> the label of init_t so thats mean that the proper domain transition is not
> available or there is something which is i'm missing.

Did you run "restorecon -v /usr/bin/mycustomeservicedaemon"?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
