Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7QB5Xv5028397
 for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2014 07:05:35 -0400
Message-ID: <53FC69F4.3010201@redhat.com>
Date: Tue, 26 Aug 2014 07:05:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Currently we can end up with different permissions on the compiled
 file_context regex files than the original.
References: <53F4B02C.90701@redhat.com> <53FB6E80.6060700@tresys.com>
In-Reply-To: <53FB6E80.6060700@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 08/25/2014 01:12 PM, Steve Lawrence wrote:
>> +	if (stat(path, &buf) < 0) {
>> +		fprintf(stderr, "Can not stat: %s: %m\n", argv[0]);
> Should the fprintf print path instead of argv[0]?
Yes.
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
> Looks good otherwise. I'll add to the repo with that change if that's okay.
>
> - Steve
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
Sounds great.
