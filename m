Message-ID: <5501CD9E.4020805@tycho.nsa.gov>
Date: Thu, 12 Mar 2015 13:32:14 -0400
From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
MIME-Version: 1.0
To: Julien Grall <julien.grall@linaro.org>, selinux@tycho.nsa.gov
Subject: Re: [Xen-devel] [PATCH 2/4] Add device tree ocontext nodes to Xen
 policy
References: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
 <1426180350-16259-3-git-send-email-dgdegra@tycho.nsa.gov>
 <5501CC8B.2040303@linaro.org>
In-Reply-To: <5501CC8B.2040303@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/12/2015 01:27 PM, Julien Grall wrote:
> Hi Daniel,
>
> On 12/03/15 17:12, Daniel De Graaf wrote:
>>   		        ;
>> +dtree_context_def	: DEVICETREECON path security_context_def
>> +		        {if (define_devicetree_context()) return -1;}
>> +		        ;
>
> The regex for matching the device tree path is different from a path.
>
> the pathname convention is:
>
> node-name@unit-address
>
> The characters allowed for node-name/unit-name are:
> 	0-9 a-z A-Z , . _ + -
>
> Although the @unit-address may be ommitted.
>
> So the regex should be something like:
> "/"({alnum}|['\._\+\-@])*

This is addressed in patch 4, where a quoted version of the path
expression is added which allows these characters (and others).

-- 
Daniel De Graaf
National Security Agency
