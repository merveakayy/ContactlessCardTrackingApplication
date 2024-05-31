using SuperHeroAPI_DotNet8.Entities;
using System.ComponentModel.DataAnnotations;

namespace UserAPI.Entities
{
    public class Beacon
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public string beaconIdentifier {  get; set; } = string.Empty; //the tracking device on the cards

        public CreditCard creditcard {  get; set; } //cards with which the tracking device is identified

}
}
