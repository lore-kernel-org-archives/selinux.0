From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, "paul@paul-moore.com" <paul@paul-moore.com>,
 "eparis@parisplace.org" <eparis@parisplace.org>, "dledford@redhat.com"
 <dledford@redhat.com>, "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 05/12] selinux: Implement Infiniband PKey "Access" access
 vector
Date: Mon, 11 Jul 2016 19:03:26 +0000
Message-ID: <DB6PR0501MB2261B291887EF0431AD5701BC43F0@DB6PR0501MB2261.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-6-git-send-email-danielj@mellanox.com>
 <1c637b46-7352-b369-4891-4b695ff80b3b@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 7/11/2016 9:45 AM, Stephen Smalley wrote:
> On 06/23/2016 03:52 PM, Dan Jurgens wrote:
>> diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
>> index a59b64e..8f2eefc 100644
>> --- a/security/selinux/include/initial_sid_to_string.h
>> +++ b/security/selinux/include/initial_sid_to_string.h
>> @@ -29,5 +29,6 @@ static const char *initial_sid_to_string[] =
>>      "policy",
>>      "scmp_packet",
>>      "devnull",
>> +    "pkey",
> I don't think we can/should add any more initial SIDs until we have
> dynamic discovery support for them.  At present, we'll have problems
> with old kernel with new policy and with new kernel with old policy when
> the number of initial SIDs changes.
>
>> +	if (c) {
>> +		if (!c->sid[0]) {
>> +			rc = sidtab_context_to_sid(&sidtab,
>> +						   &c->context[0],
>> +						   &c->sid[0]);
>> +			if (rc)
>> +				goto out;
>> +		}
>> +		*out_sid = c->sid[0];
>> +	} else {
>> +		*out_sid = SECINITSID_PKEY;
> Could we just use SECINITSID_UNLABELED as the default?
>
I don't see why that would be a problem.  I'll take the same comment for the "[PATCH 06/12] selinux: Add IB End Port SMP access vector".
