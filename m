Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PEEJUT024401
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 10:14:19 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3PEEHQt006953
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 14:14:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
Date: Wed, 25 Apr 2007 10:14:17 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A71B39@exchange.columbia.tresys.com>
In-Reply-To: <1177476585.3428.91.camel@localhost.localdomain>
References: <20070423213455.741326000@tresys.com> <20070423213721.090230000@tresys.com> <1177444855.10744.25.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com> <1177476585.3428.91.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
<snip>
> >  The
> > per-component versioning was discussed but thought to be too much 
> > overhead for the number of objects we are serializing.
> > 
> 
> I guess the problem with this is it is hard to know exactly 
> what the version is for. Per-component headers seem better to me.
> 

Ok, we can talk about it but it seems like a lot of overhead for no good
reason to version everything.

> > > <snip>

> > It works basically the same way the current policy serialization 
> > works, pass in the data once to get size, allocate and pass in the 
> > buffer to which its being serialized. We did this for 
> consistency with 
> > the current mechanisms.
> > 
> 
> I'm not certain that I would use the current policy 
> serialization code as an example for anything - it is very 
> difficult to work with.
> 

Fair enough.

> > 
> > SEPOL_SERIAL_SIZE_T is always 64 bits. We should be checking if it 
> > tries to serialize into a smaller type, if not that's a bug.
> > 
> 
> How can that be? On a 64bit platform I can represent a size 
> that can't be represented by a 32bit size_t. How can I 
> transfer this data to a 32bit system? I can't put it in a 
> data structure with size_t - it would have to be unint64_t. 
> So why not just use that?
> 

That's why I said "We should be checking if it tries to serialize into a
smaller type, if not that's a bug"

IIRC we needed something that could serialize/unserialize size_t because
its used in some components that we serialize. We could always cast to
uint64_t and serialize it that way (which is pretty much what we are
doing anyway). 

> > 
> > IIRC because we use the same entry point for all data types 
> to get to 
> > these.
> > 
> 
> But you know it is a string.
> 

Fine.

> > > > + *  SEPOL_SERIAL_STRING_ARRAY
> > > > + *    Serializes a char**.
> > > > + *    datum may be NULL.
> > > > + *    datum_length should be the size of the array.
> > > > + *    Each string will be serialized as per 
> > > SEPOL_SERIAL_STRING and its size
> > > > + *    determined via strlen.
> > > > + *
> > > > + *  NULL pointers are distinguished (where they are
> > > allowed at all).
> > > > + *  In the case of strings this means that a NULL char* has a 
> > > > + different
> > > > + *  serialization from the empty string "".
> > > 
> > > Why?
> > > 
> > 
> > Not sure, will check.
> > 
> > > > + *
> > > > + */
> > > > +int sepol_serialize(sepol_handle_t * handle,
> > > > +		    const void *datum,
> > > > +		    size_t datum_length,
> > > > +		    unsigned int datum_type, char **data,
> > > uint64_t * size) {
> > > 
> > > Why a single multiplexed function? Seems _much_ easier to have a 
> > > sepol_serialize_string, sepol_serialize_uint32, etc.
> > > This would allow type safety and improve readability, both at the 
> > > call site and the definition.
> > > 
> > 
> > We can do that I guess, IMO it doesn't make much of a difference.
> > 
> 
> I think it makes a big difference.
> 

I don't know why, this is closer to what we want anyway, where we can
just call object->serialize and get a serialized version.

> > > 
> > > <snip>
> > > 
> > > > +		case SEPOL_SERIAL_SIZE_T:
> > > > +			if (size == NULL) {
> > > > +				temp = calloc(1, 
> sizeof(uint64_t));
> > > > +				if (temp == NULL) {
> > > > +					status = STATUS_ERR;
> > > > +					goto cleanup;
> > > > +				}
> > > > +
> > > > +				*((uint64_t *)temp) =
> > > cpu_to_le64(*((size_t *) datum));
> > > > +
> > > > +				memcpy(*data, temp, 
> sizeof(uint64_t));
> > > > +				*data += sizeof(uint64_t);
> > > > +			}
> > > > +			else
> > > > +				*size += sizeof(uint64_t);
> > > > +			break;
> > > 
> > > Err - I don't think this is allowed. I believe that size_t is 
> > > supposed to be word size and there is no reason that word size is 
> > > limited to 64 bits.
> > > 
> > 
> > IIRC in ANSI C it is limited to 64 bits. I might be wrong 
> on this but 
> > I remember us looking it up when this happened.
> > 
> 
> That sounds unlikely, but more importantly, why? Why not just 
> use uint64_t?
> 

Because some things we serialize are size_t so we must unserialize into
size_t. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
