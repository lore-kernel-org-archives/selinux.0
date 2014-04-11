Message-ID: <5347DEAC.6070407@tycho.nsa.gov>
Date: Fri, 11 Apr 2014 08:23:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Security server responses always based on class?
References: <53478F76.7040700@gmail.com> <5347DD46.9060705@tycho.nsa.gov>
In-Reply-To: <5347DD46.9060705@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/11/2014 08:17 AM, Stephen Smalley wrote:
> On 04/11/2014 02:45 AM, dE wrote:
>> Does the object manager always queries the security server based on
>> classes? And does the security server always respond with an access vector?
>>
>> OR
>>
>> Can the object manager query the security server on specific permissions
>> (which make up a class) without querying for a response for the whole
>> security class?
> 
> The security server interface is security_compute_av(), which always
> computes the entire access vector for the class.
> 
> Object managers however will typically call the Access Vector Cache
> (AVC) interface avc_has_perm(), which checks particular permissions.
> Internally, the AVC calls security_compute_av() if the access vector is
> not already cached for the (source context, target context, target
> class) triple and caches the result.
> 
> More recent work on userspace object managers has introduced a higher
> level API, selinux_check_access(), which internally handles the mapping
> of contexts to SIDs and the mapping of class and permission strings to
> values and calls avc_has_perm().
> 
> All of these APIs are provided by libselinux and have corresponding man
> pages.

I forgot to mention:  the security_compute_av() API takes a requested
permission argument to indicate the permissions being checked by the
caller, and the returned av_decision structure includes a decided access
vector to indicate which permissions were actually computed in the
allowed/auditallow/auditdeny vectors.  That allowed the security server
to optionally only compute the subset of permissions directly requested
by the caller and force the object manager to call again if any other
permissions are later requested.  However, this was optimized away from
the kernel a while back as it was unused by our security server so the
kernel always returns a decided vector with all-bits-set now.
